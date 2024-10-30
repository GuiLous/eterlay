class Tickets::DeleteService
  def initialize(params)
    @params = params
  end

  def call
    ticket = Ticket.find(@params[:id])

    return failure(ticket.errors.full_messages) unless ticket.destroy

    success(ticket)
  rescue StandardError => e
    failure([ "Um erro inesperado ocorreu: #{e.message}" ])
  end

  private

  def success(ticket)
    OpenStruct.new(
      success?: true,
      deleted_id: ticket.id,
      errors: []
    )
  end

  def failure(errors)
    OpenStruct.new(
      success?: false,
      deleted_id: nil,
      errors: errors
    )
  end
end
