class Tickets::UpdateService
  def initialize(params)
    @params = params
  end

  def call
    ticket = Ticket.find(@params[:id])

    update_params = @params.compact_blank

    return failure(ticket.errors.full_messages) unless ticket.update(update_params)

    success(ticket)
  rescue StandardError => e
    failure([ "Um erro inesperado ocorreu: #{e.message}" ])
  end

  private

  def success(ticket)
    OpenStruct.new(
      updated_id: ticket.id,
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
