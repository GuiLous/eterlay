class ShopifyOrderItem < ApplicationRecord
  has_many :ticket_codes, dependent: :destroy

  validates :order_id, presence: true, uniqueness: true
  validates :product_id, presence: true
  validates :title, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true
  validates :customer_email, presence: true
  validates :customer_name, presence: true
end
