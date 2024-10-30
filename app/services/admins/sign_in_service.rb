require "ostruct"

class Admins::SignInService
  def initialize(params)
    @params = params
  end

  def call
    admin = Admin.find_for_database_authentication(@params)

    return failure([ "Credenciais inválidas" ]) unless admin&.valid_password?(@params[:password])

    token = admin.generate_jwt

    context[:current_user] = admin

    success(token)
  rescue StandardError => e
    failure([ "Um erro inesperado ocorreu: #{e.message}" ])
  end

  private

  def success(token)
    OpenStruct.new(
      success?: true,
      token: token,
      errors: []
    )
  end

  def failure(errors)
    OpenStruct.new(
      success?: false,
      token: nil,
      errors: errors
    )
  end
end
