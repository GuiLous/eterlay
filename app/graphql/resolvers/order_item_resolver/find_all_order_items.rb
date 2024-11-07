module Resolvers
  module OrderItemResolver
    class FindAllOrderItems < BaseResolver
      # include ::Authenticatable

      type [ Types::OrderItem::OrderItemType ], null: true

      def resolve
        # authenticate_user!

        ShopifyOrderItem.all
      end
    end
  end
end
