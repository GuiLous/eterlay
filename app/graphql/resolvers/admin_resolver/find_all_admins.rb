module Resolvers
  module AdminResolver
    class FindAllAdmins < BaseResolver
      include ::Authenticatable

      type [ Types::Admin::AdminType ], null: true

      def resolve
        authenticate_user!

        Admin.all
      end
    end
  end
end
