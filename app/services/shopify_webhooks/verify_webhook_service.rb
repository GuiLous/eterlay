module ShopifyWebhooks::VerifyWebhookService
  def initialize(data, hmac_header)
    @data = data
    @hmac_header = hmac_header
  end

  def verify
    return false unless @data.present? && @hmac_header.present?

    digest = OpenSSL::HMAC.digest("sha256", ENV["SHOPIFY_WEBHOOK_SECRET"], @data)
    Base64.strict_encode64(digest) == @hmac_header
  rescue StandardError
    false
  end
end
