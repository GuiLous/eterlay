# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_admin, mutation: Mutations::AdminMutation::CreateAdmin
    field :sign_in_admin, mutation: Mutations::AdminMutation::SignInAdmin
    field :delete_admin, mutation: Mutations::AdminMutation::DeleteAdmin
    field :create_ticket, mutation: Mutations::TicketMutation::CreateTicket
    field :delete_ticket, mutation: Mutations::TicketMutation::DeleteTicket
    field :update_ticket, mutation: Mutations::TicketMutation::UpdateTicket

    field :update_ticket_used, mutation: Mutations::TicketCodeMutation::UpdateTicketUsed
    field :delete_ticket_code, mutation: Mutations::TicketCodeMutation::DeleteTicketCode

    field :create_order_item, mutation: Mutations::OrderItemMutation::CreateOrderItem
    field :delete_order_item, mutation: Mutations::OrderItemMutation::DeleteOrderItem
  end
end
