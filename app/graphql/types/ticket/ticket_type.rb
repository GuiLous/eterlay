module Types
  module Ticket
    class TicketType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :description, String, null: true
      field :qr_code_image_url, String, null: false

      def qr_code_image_url
        Rails.application.routes.url_helpers.rails_blob_path(object.qr_code_image, only_path: true) if object.qr_code_image.attached?
      end
    end
  end
end
