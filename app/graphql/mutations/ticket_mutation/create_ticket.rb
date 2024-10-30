module Mutations
  module TicketMutation
    class CreateTicket < BaseMutation
      include ::Authenticatable

      argument :name, String
      argument :description, String, required: false
      argument :qr_code_image, ApolloUploadServer::Upload

      field :ticket, Types::Ticket::TicketType
      field :errors, [ String ], null: false

      def resolve(name:, description:, qr_code_image:)
        puts "name: #{name}"
        puts "description: #{description}"
        puts "qr_code_image: #{qr_code_image}"
        authenticate_user!

        result = Tickets::CreateService.new(
          name:,
          description:,
          qr_code_image:,
        ).call

        { ticket: result.ticket, errors: result.errors }
      end
    end
  end
end
