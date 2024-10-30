module Resolvers
  class TicketResolver < BaseResolver
    include ::Authenticatable

    type Types::Ticket::TicketType, null: true

    argument :id, ID, required: true

    def resolve(id:)
      authenticate_user!

      Ticket.find(id)
    end
  end

  class TicketsResolver < BaseResolver
    include ::Authenticatable

    type [ Types::Ticket::TicketType ], null: true

    def resolve
      authenticate_user!

      Ticket.all
    end
  end
end
