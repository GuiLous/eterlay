module Mutations
  module AdminMutation
    class CreateAdmin < BaseMutation
      argument :email, String
      argument :password, String
      argument :password_confirmation, String
      argument :first_name, String
      argument :last_name, String
      argument :phone_number, String

      field :admin, Types::Admin::AdminType, null: true
      field :errors, [ String ], null: true

      def resolve(email:, password:, password_confirmation:, first_name:, last_name:, phone_number:)
        result = Admins::CreateService.new(
          email:,
          password:,
          password_confirmation:,
          first_name:,
          last_name:,
          phone_number:
        ).call

        { admin: result.admin, errors: result.errors }
      end
    end
  end
end
