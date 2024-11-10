require "ostruct"

class TicketCodes::DeleteService
  def initialize(params)
    @params = params
  end

  def call
    ticket_code = TicketCode.find(@params[:id])

    return failure(ticket_code.errors.full_messages) unless ticket_code.destroy

    success(ticket_code)
  rescue StandardError => e
    failure([ "Um erro inesperado ocorreu: #{e.message}" ])
  end

  private

  def success(ticket_code)
    OpenStruct.new(
      deleted_id: ticket_code.id,
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
