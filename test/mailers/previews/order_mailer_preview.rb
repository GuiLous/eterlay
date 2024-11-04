class OrderMailerPreview < ActionMailer::Preview
  def order_confirmation
    OrderMailer.order_confirmation(ShopifyOrderItem.last)
  end
end
