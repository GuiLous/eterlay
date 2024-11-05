class TicketCodes::UpdateService
  def initialize(params)
    @params = params
  end

  def call
    ticket_code = TicketCode.find_by(uuid: @params[:uuid])

    return failure(ticket_code.errors.full_messages) unless ticket_code.update(used: true, used_at: Time.current)

    success(ticket_code)
  rescue StandardError => e
    failure([ "Um erro inesperado ocorreu: #{e.message}" ])
  end

  private

  def success(ticket_code)
    OpenStruct.new(
      updated_id: ticket_code.id,
      errors: []
    )
  end

  def failure(errors)
    OpenStruct.new(
      updated_id: nil,
      errors: errors
    )
  end
end
