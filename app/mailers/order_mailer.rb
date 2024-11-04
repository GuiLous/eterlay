require "rqrcode"
require "mini_magick"
require "stringio"

class OrderMailer < ApplicationMailer
  def order_confirmation(order_item)
    @order_item = order_item
    @customer_email = order_item.customer_email
    @customer_name = order_item.customer_name
    @ticket_code = order_item.ticket_code

    if @ticket_code.present?
      begin
        qr_code_image = generate_qr_code_image(@ticket_code.uuid)
        attachments.inline["qrcode.png"] = {
          mime_type: "image/png",
          content: qr_code_image.to_blob
        }
      rescue => e
        puts e.backtrace
      end
    end

    mail(
      to: @order_item.customer_email,
      subject: "Confirmação do seu pedido com QR Code"
    )
  end

  private

  def generate_qr_code_image(uuid)
    qrcode = RQRCode::QRCode.new(uuid)
    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      fill: "white",
      module_px_size: 6,
      size: 120
    )

    image = MiniMagick::Image.read(StringIO.new(png.to_s))
    image.format "png"
    image
  end
end
