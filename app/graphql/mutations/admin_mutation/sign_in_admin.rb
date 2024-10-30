module Mutations
  module AdminMutation
    class SignInAdmin < BaseMutation
      argument :email, String
      argument :password, String

      field :token, String, null: true
      field :errors, [ String ], null: true

      def resolve(email:, password:)
        result = Admins::SignInService.new(email:, password:, context:).call

        { token: result.token, errors: result.errors }
      end
    end
  end
end
