# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :admin, resolver: Resolvers::AdminResolver::FindAdmin
    field :admins, resolver: Resolvers::AdminResolver::FindAllAdmins

    field :ticket, resolver: Resolvers::TicketResolver::FindTicket
    field :tickets, resolver: Resolvers::TicketResolver::FindAllTickets

    field :order_items, resolver: Resolvers::OrderItemResolver::FindAllOrderItems

    field :ticket_codes, resolver: Resolvers::TicketCodeResolver::FindAllTicketCodes
  end
end
