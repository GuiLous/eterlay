module Mutations
  module AdminMutation
    class SignInAdmin < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :token, String, null: true
      field :errors, [ String ], null: true

      def resolve(email:, password:)
        result = Admins::SignInService.new(email:, password:, context:).call

        { token: result.token, errors: result.errors }
      end
    end
  end
end
