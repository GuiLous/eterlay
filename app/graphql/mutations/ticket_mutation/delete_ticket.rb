module Mutations
  module TicketMutation
    class DeleteTicket < BaseMutation
      include ::Authenticatable

      argument :id, ID, required: true

      field :success, Boolean, null: false
      field :deleted_id, ID, null: true
      field :errors, [ String ], null: false

      def resolve(id:)
        authenticate_user!

        result = Tickets::DeleteService.new(id:).call

        { success: result.success?, deleted_id: result.deleted_id, errors: result.errors }
      end
    end
  end
end