module Types
  module Admin
    class AdminType < Types::BaseObject
      field :id, ID, null: false
      field :first_name, String, null: false
      field :last_name, String, null: false
      field :email, String, null: false
      field :phone_number, String, null: false
      field :is_active, Boolean, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
