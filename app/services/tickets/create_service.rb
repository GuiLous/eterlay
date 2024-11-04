require "ostruct"

class Tickets::CreateService
  def initialize(params)
    @params = params
  end

  def call
    ticket = Ticket.new(
      name: @params[:name],
      description: @params[:description],
      city: @params[:city],
      state: @params[:state],
      location: @params[:location],
      date: @params[:date],
      footer_description: @params[:footer_description]
    )

    return failure(ticket.errors.full_messages) unless ticket.save

    success(ticket)
  rescue StandardError => e
    failure([ "Um erro inesperado ocorreu: #{e.message}" ])
  end

  private

  def success(ticket)
    OpenStruct.new(
      success?: true,
      ticket: ticket,
      errors: []
    )
  end

  def failure(errors)
    OpenStruct.new(
      success?: false,
      ticket: nil,
      errors: errors
    )
  end
end
