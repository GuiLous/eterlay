class TicketWebhookController < ApplicationController
  def orders_paid
    hmac_header = request.headers["X-Shopify-Hmac-SHA256"]
    data = request.body.read

    # return head :unauthorized unless hmac_header.present?
    # return head :unauthorized unless ShopifyWebhooks::VerifyWebhookService.new(data, hmac_header).verify

    begin
      order = JSON.parse(data)
      OrderItems::ProcessorService.new(order).process
      head :ok
    rescue JSON::ParserError
      head :unprocessable_entity
    rescue StandardError
      head :internal_server_error
    end
  end
end
