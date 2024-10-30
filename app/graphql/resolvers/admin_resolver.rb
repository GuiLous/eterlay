module Resolvers
  class AdminResolver < BaseResolver
    include ::Authenticatable

    type Types::Admin::AdminType, null: true

    argument :id, ID, required: true

    def resolve(id:)
      authenticate_user!

      Admin.find(id)
    end
  end

  class AdminsResolver < BaseResolver
    include ::Authenticatable

    type [ Types::Admin::AdminType ], null: true

    def resolve
      authenticate_user!

      Admin.all
    end
  end
end
