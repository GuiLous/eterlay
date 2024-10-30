module Mutations
  module AdminMutation
    class SignInAdmin < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :token, String, null: true
      field :errors, [ String ], null: true

      def resolve(email:, password:)
        admin = Admin.find_for_database_authentication(email:)

        unless admin&.valid_password?(password)
          return { token: nil, errors: [ "Invalid email or password" ] }
        end

        token = admin.generate_jwt

        context[:current_user] = admin

        { token: token, errors: [] }
      rescue StandardError => e
        { token: nil, errors: [ "An unexpected error occurred: #{e.message}" ] }
      end
    end
  end
end
