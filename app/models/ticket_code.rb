class TicketCode < ApplicationRecord
  belongs_to :shopify_order_item
  has_one_attached :qr_code

  before_create :generate_uuid

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
