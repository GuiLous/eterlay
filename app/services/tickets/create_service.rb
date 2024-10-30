require "ostruct"

class Tickets::CreateService
  def initialize(params)
    @params = params
  end

  def call
    ticket = Ticket.new(
      name: @params[:name],
      description: @params[:description]
    )

    blob = ActiveStorage::Blob.create_and_upload!(
      io: @params[:qr_code_image],
      filename: @params[:qr_code_image].original_filename,
      content_type: @params[:qr_code_image].content_type
    )

    ticket.qr_code_image.attach(blob)

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
