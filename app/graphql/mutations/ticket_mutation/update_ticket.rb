module Mutations
  module TicketMutation
    class UpdateTicket < BaseMutation
      include ::Authenticatable

      argument :id, ID
      argument :name, String, required: false
      argument :description, String, required: false
      argument :qr_code_image, ApolloUploadServer::Upload, required: false

      field :updated_id, ID, null: true
      field :errors, [ String ], null: false

      def resolve(**attributes)
        authenticate_user!

        result = Tickets::UpdateService.new(**attributes).call

        { updated_id: result.updated_id, errors: result.errors }
      end
    end
  end
end
