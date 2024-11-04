class RemoveQrCodeImageFromTickets < ActiveRecord::Migration[7.2]
  def change
    Ticket.all.each do |ticket|
      ticket.qr_code_image.purge if ticket.qr_code_image.attached?
    end
  end
end
