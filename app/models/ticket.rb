class Ticket < ApplicationRecord
  validates :name, presence: { message: "Nome é obrigatório" }, uniqueness: { message: "Nome já está em uso" }
  validates :city, presence: { message: "Cidade é obrigatória" }
  validates :state, presence: { message: "Estado é obrigatório" }
  validates :location, presence: { message: "Local é obrigatório" }
  validates :date, presence: { message: "Data é obrigatória" }
  validates :footer_description, presence: { message: "Descrição do rodapé é obrigatória" }
end
