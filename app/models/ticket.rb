class Ticket < ApplicationRecord
  validates :name, presence: { message: "Nome é obrigatório" }, uniqueness: { message: "Nome já está em uso" }

  has_one_attached :qr_code_image
end
