class TicketWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def orders_paid
    hmac_header = request.headers["X-Shopify-Hmac-SHA256"]
    data = request.body.read

    verified = verify_webhook(data, hmac_header)

    return head :unauthorized unless verified

    order = JSON.parse(data)
    process_paid_order(order)
    head :ok
  end

  private

  def verify_webhook(data, hmac_header)
    digest = OpenSSL::HMAC.digest("sha256", ENV["SHOPIFY_WEBHOOK_SECRET"], data)
    Base64.strict_encode64(digest) == hmac_header
  end

  def process_paid_order(order)
    order["line_items"].each do |item|
      process_line_item(item)
    end
  end

  def process_line_item(item)
    product_id = item["product_id"]
    variant_id = item["variant_id"]
    quantity = item["quantity"]
    price = item["price"]

    puts "Item: #{item.pretty_inspect}"
  end
end
