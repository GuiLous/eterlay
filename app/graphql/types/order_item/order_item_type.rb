module Types
  module OrderItem
    class OrderItemType < Types::BaseObject
      field :id, ID, null: false
      field :title, String, null: false
      field :quantity, Integer, null: false
      field :price, String, null: false
      field :customer_email, String, null: false
      field :customer_name, String, null: false
      field :customer_phone, String
    end
  end
end
