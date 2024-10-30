class Ticket < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_one_attached :qr_code_image
end
