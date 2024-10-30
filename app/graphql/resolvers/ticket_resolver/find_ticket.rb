module Resolvers
  module TicketResolver
    class FindTicket < BaseResolver
      include ::Authenticatable

      type Types::Ticket::TicketType, null: true

      argument :id, ID, required: true

      def resolve(id:)
        authenticate_user!

        Ticket.find(id)
      end
    end
  end
end
