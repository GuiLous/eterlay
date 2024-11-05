# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_admin, mutation: Mutations::AdminMutation::CreateAdmin
    field :sign_in_admin, mutation: Mutations::AdminMutation::SignInAdmin

    field :create_ticket, mutation: Mutations::TicketMutation::CreateTicket
    field :delete_ticket, mutation: Mutations::TicketMutation::DeleteTicket
    field :update_ticket, mutation: Mutations::TicketMutation::UpdateTicket

    field :update_ticket_used, mutation: Mutations::TicketCodeMutation::UpdateTicketUsed
  end
end
