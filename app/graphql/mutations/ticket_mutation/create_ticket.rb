module Mutations
  module TicketMutation
    class CreateTicket < BaseMutation
      # include ::Authenticatable

      argument :name, String
      argument :description, String, required: false
      argument :city, String
      argument :state, String
      argument :location, String
      argument :date, GraphQL::Types::ISO8601DateTime
      argument :footer_description, String, required: false

      field :ticket, Types::Ticket::TicketType
      field :errors, [ String ], null: false

      def resolve(name:, description:, city:, state:, location:, date:, footer_description:)
        # authenticate_user!

        result = Tickets::CreateService.new(
          name:,
          description:,
          city:,
          state:,
          location:,
          date:,
          footer_description:,
        ).call

        { ticket: result.ticket, errors: result.errors }
      end
    end
  end
end
