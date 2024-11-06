module Types
  module TicketCode
    class TicketCodeType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :used, Boolean, null: false
      field :uuid, String, null: false
      field :used_at, GraphQL::Types::ISO8601DateTime
    end
  end
end
