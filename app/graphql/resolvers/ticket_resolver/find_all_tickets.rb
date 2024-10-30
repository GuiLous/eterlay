module Resolvers
  module TicketResolver
    class FindAllTickets < BaseResolver
      include ::Authenticatable

      type [ Types::Ticket::TicketType ], null: true

      def resolve
        authenticate_user!

        Ticket.all
      end
    end
  end
end
