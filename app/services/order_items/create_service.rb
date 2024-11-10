class OrderItems::CreateService
  def initialize(params)
    @params = params
    @used = @params[:manual]
  end

  def call
    order_item = ShopifyOrderItem.create!(@params)

    order_item.quantity.times do
      TicketCode.create!(shopify_order_item: order_item, used: @used, used_at: @used ? Time.current : nil)
    end

    order_item.reload
  end
end
