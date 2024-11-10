require "ostruct"

class Admins::DeleteService
  def initialize(params)
    @params = params
  end

  def call
    admin = Admin.find(@params[:id])

    return failure(admin.errors.full_messages) unless admin.destroy

    success(admin)
  rescue StandardError => e
    failure([ "Um erro inesperado ocorreu: #{e.message}" ])
  end

  private

  def success(admin)
    OpenStruct.new(
      deleted_id: admin.id,
      errors: []
    )
  end

  def failure(errors)
    OpenStruct.new(
      deleted_id: nil,
      errors: errors
    )
  end
end
