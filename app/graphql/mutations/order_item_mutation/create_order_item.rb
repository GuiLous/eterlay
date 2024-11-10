module Mutations
  module OrderItemMutation
    class CreateOrderItem < BaseMutation
      # include ::Authenticatable

      argument :title, String
      argument :quantity, Integer
      argument :price, String
      argument :customer_email, String
      argument :customer_name, String
      argument :customer_phone, String, required: false

      field :order_item, Types::OrderItem::OrderItemType
      field :errors, [ String ], null: false

      def resolve(title:, quantity:, price:, customer_email:, customer_name:, customer_phone:)
        # authenticate_user!

        result = OrderItems::CreateService.new(
          title:,
          quantity:,
          price:,
          customer_email:,
          customer_name:,
          customer_phone:,
          manual: true,
        ).call

        { order_item: result, errors: [] }
      rescue StandardError => e
        { order_item: nil, errors: [ "Um erro inesperado ocorreu: #{e.message}" ] }
      end
    end
  end
end
