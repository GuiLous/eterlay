class OrderItems::ProcessorService
  def initialize(order_data)
    @order_data = order_data
  end

  def process
    raise ArgumentError, "Missing line_items in order data" unless @order_data["line_items"].present?

    ActiveRecord::Base.transaction do
      @order_data["line_items"].each do |item|
        order_item = build_order_item(item)
        created_item = create_order_item(order_item)
        OrderMailer.order_confirmation(created_item).deliver_now
      end
    end
  end

  private

  def build_order_item(item)
    {
      order_id: @order_data["id"],
      product_id: item["product_id"],
      variant_id: item["variant_id"],
      title: item["title"],
      quantity: item["quantity"],
      price: item["price"],
      customer_email: @order_data["email"],
      customer_name: extract_customer_name(@order_data["customer"]),
      customer_phone: @order_data.dig("customer", "phone")
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
