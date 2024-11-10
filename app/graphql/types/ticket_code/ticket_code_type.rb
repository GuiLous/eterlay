module Types
  module TicketCode
    class TicketCodeType < Types::BaseObject
      field :id, ID, null: false
      field :uuid, String, null: false
      field :used, Boolean, null: false
      field :used_at, GraphQL::Types::ISO8601DateTime
      field :shopify_order_item, Types::OrderItem::OrderItemType, null: false
    end
  end
end
