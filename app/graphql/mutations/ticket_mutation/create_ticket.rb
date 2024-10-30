module Mutations
  module TicketMutation
    class CreateTicket < BaseMutation
      include ::Authenticatable

      argument :name, String, required: true
      argument :description, String
      argument :qr_code_image, ApolloUploadServer::Upload, required: true

      field :ticket, Types::Ticket::TicketType
      field :errors, [ String ], null: false

      def resolve(name:, description:, qr_code_image:)
        authenticate_user!

        ticket = Ticket.new(
          name: name,
          description: description
        )

        blob = ActiveStorage::Blob.create_and_upload!(
          io: qr_code_image,
          filename: qr_code_image.original_filename,
          content_type: qr_code_image.content_type
        )

        ticket.qr_code_image.attach(blob)

        return { ticket: nil, errors: ticket.errors.full_messages } unless ticket.save

        { ticket: ticket, errors: [] }
      rescue StandardError => e
        { ticket: nil, errors: [ "An unexpected error occurred: #{e.message}" ] }
      end
    end
  end
end
