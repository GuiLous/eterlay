module Resolvers
  module TicketCodeResolver
    class FindAllTicketCodes < BaseResolver
      # include ::Authenticatable

      type [ Types::TicketCode::TicketCodeType ], null: true

      def resolve
        # authenticate_user!
        TicketCode.all.order(created_at: :desc)
      end
    end
  end
end
