# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Admin Mutations
    field :create_admin, mutation: Mutations::AdminMutation::CreateAdmin
    field :sign_in_admin, mutation: Mutations::AdminMutation::SignInAdmin

    # Ticket Mutations
    field :create_ticket, mutation: Mutations::TicketMutation::CreateTicket
    field :delete_ticket, mutation: Mutations::TicketMutation::DeleteTicket
    field :update_ticket, mutation: Mutations::TicketMutation::UpdateTicket
  end
end
