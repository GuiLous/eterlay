# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_admin, mutation: Mutations::AdminMutation::CreateAdmin
    field :sign_in_admin, mutation: Mutations::AdminMutation::SignInAdmin
    field :create_ticket, mutation: Mutations::TicketMutation::CreateTicket
  end
end
