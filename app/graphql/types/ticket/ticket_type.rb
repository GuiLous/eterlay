module Types
  module Ticket
    class TicketType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :description, String
      field :city, String,  null: false
      field :state, String,  null: false
      field :location, String,  null: false
      field :date, GraphQL::Types::ISO8601DateTime,  null: false
      field :footer_description, String,  null: false
    end
  end
end
