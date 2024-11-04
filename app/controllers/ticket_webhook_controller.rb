class TicketWebhookController < ApplicationController
  def orders_paid
    hmac_header = request.headers["X-Shopify-Hmac-SHA256"]
    data = request.body.read

    # return head :unauthorized unless hmac_header.present?
    # return head :unauthorized unless verify_webhook(data, hmac_header)

    begin
      order = JSON.parse(data)
      save_order_items(order)
      head :ok
    rescue JSON::ParserError
      head :unprocessable_entity
    rescue StandardError
      head :internal_server_error
    end
  end

  private

  def verify_webhook(data, hmac_header)
    return false unless data.present? && hmac_header.present?

    digest = OpenSSL::HMAC.digest("sha256", ENV["SHOPIFY_WEBHOOK_SECRET"], data)
    Base64.strict_encode64(digest) == hmac_header
  rescue StandardError
    false
  end

  def save_order_items(order_data)
    raise ArgumentError, "Missing line_items in order data" unless order_data["line_items"].present?

    ActiveRecord::Base.transaction do
      order_data["line_items"].each do |item|
        order_item = build_order_item(order_data, item)
        created_item = create_order_item(order_item)
        OrderMailer.order_confirmation(created_item).deliver_now
      end
    end
  end

  def build_order_item(order_data, item)
    {
      order_id: order_data["id"],
      product_id: item["product_id"],
      variant_id: item["variant_id"],
      title: item["title"],
      quantity: item["quantity"],
      price: item["price"],
      customer_email: order_data["email"],
      customer_name: extract_customer_name(order_data["customer"]),
      customer_phone: order_data.dig("customer", "phone")
    }
  end

  def create_order_item(order_data)
    order_item = ShopifyOrderItem.create!(order_data)

    TicketCode.create!(shopify_order_item: order_item)

    order_item.reload
  end



  def extract_customer_name(customer)
    return nil if customer.blank?

    [ customer["first_name"], customer["last_name"] ].compact.join(" ").presence
  rescue StandardError
    nil
  end
end
