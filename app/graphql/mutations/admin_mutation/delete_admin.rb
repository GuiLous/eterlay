module Mutations
  module AdminMutation
    class DeleteAdmin < BaseMutation
      # include ::Authenticatable

      argument :id, ID

      field :deleted_id, ID, null: true
      field :errors, [ String ], null: false

      def resolve(id:)
        # authenticate_user!

        result = Admins::DeleteService.new(id:).call

        { deleted_id: result.deleted_id, errors: result.errors }
      end
    end
  end
end
