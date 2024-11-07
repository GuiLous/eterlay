module Resolvers
  module AdminResolver
    class FindAdmin < BaseResolver
      # include ::Authenticatable

      type Types::Admin::AdminType, null: true

      argument :id, ID, required: true

      def resolve(id:)
        # authenticate_user!

        Admin.find(id)
      end
    end
  end
end
