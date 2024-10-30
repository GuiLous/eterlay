class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :first_name, presence: { message: "Nome é obrigatório" }
  validates :last_name, presence: { message: "Sobrenome é obrigatório" }
  validates :phone_number, presence: { message: "Número de telefone é obrigatório" }, uniqueness: { message: "Número de telefone já está em uso" }

  def generate_jwt
    JWT.encode({ id: id, exp: 60.days.from_now.to_i }, Rails.application.credentials.secret_key_base)
  end
end
