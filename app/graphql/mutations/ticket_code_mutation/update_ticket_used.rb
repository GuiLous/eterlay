module Mutations
  module TicketCodeMutation
    class UpdateTicketUsed < BaseMutation
      include ::Authenticatable

      argument :uuid, ID

      field :updated_id, ID, null: true
      field :errors, [ String ], null: false

      def resolve(uuid:)
        authenticate_user!

        result = TicketCodes::UpdateService.new(uuid:).call

        { updated_id: result.updated_id, errors: result.errors }
      end
    end
  end
end
