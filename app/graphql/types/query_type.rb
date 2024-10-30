# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :admin, resolver: Resolvers::AdminResolver
    field :admins, resolver: Resolvers::AdminsResolver

    field :ticket, resolver: Resolvers::TicketResolver
    field :tickets, resolver: Resolvers::TicketsResolver
  end
end
