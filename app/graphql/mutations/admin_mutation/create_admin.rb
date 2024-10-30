module Mutations
  module AdminMutation
    class CreateAdmin < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :phone_number, String, required: true

      field :admin, Types::Admin::AdminType, null: true
      field :errors, [ String ], null: true

      def resolve(email:, password:, password_confirmation:, first_name:, last_name:, phone_number:)
        admin = Admin.new(email:, password:, password_confirmation:, first_name:, last_name:, phone_number:)

        return { admin: nil, errors: admin.errors.full_messages } unless admin.save

        { admin: admin, errors: [] }
      rescue StandardError => e
        { admin: nil, errors: [ "An unexpected error occurred: #{e.message}" ] }
      end
    end
  end
end
