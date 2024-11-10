require "ostruct"

class OrderItems::DeleteService
  def initialize(params)
    @params = params
  end

  def call
    order_item = ShopifyOrderItem.find(@params[:id])

    TicketCode.where(shopify_order_item_id: order_item.id).destroy_all

    return failure(order_item.errors.full_messages) unless order_item.destroy

    success(order_item)
  rescue StandardError => e
    failure([ "Um erro inesperado ocorreu: #{e.message}" ])
  end

  private

  def success(order_item)
    OpenStruct.new(
      deleted_id: order_item.id,
      errors: []
    )
  end

  def failure(errors)
    OpenStruct.new(
      deleted_id: nil,
      errors: errors
    )
  end
end
