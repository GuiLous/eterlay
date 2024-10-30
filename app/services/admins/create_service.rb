require "ostruct"

class Admins::CreateService
  def initialize(params)
    @params = params
  end

  def call
    admin = Admin.create(@params)

    return failure(admin.errors.full_messages) unless admin.save

    success(admin)
  rescue StandardError => e
    failure([ "Um erro inesperado ocorreu: #{e.message}" ])
  end

  private

  def success(admin)
    OpenStruct.new(
      success?: true,
      admin: admin,
      errors: []
    )
  end

  def failure(errors)
    OpenStruct.new(
      success?: false,
      admin: nil,
      errors: errors
    )
  end
end
