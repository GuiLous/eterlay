class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  enum role: {
    member: 0,
    director: 1,
    master: 2
  }, _default: :member

  validates :first_name, presence: { message: "Nome é obrigatório" }
  validates :last_name, presence: { message: "Sobrenome é obrigatório" }
  validates :phone_number, presence: { message: "Número de telefone é obrigatório" }, uniqueness: { message: "Número de telefone já está em uso" }

  def generate_jwt
    JWT.encode({
        id: id,
        email: email,
        firstName: first_name,
        lastName: last_name,
        phoneNumber: phone_number,
        role: role,
        exp: 60.days.from_now.to_i
      },
      Rails.application.credentials.secret_key_base
    )
  end
end
