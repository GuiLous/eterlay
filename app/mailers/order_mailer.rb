require "rqrcode"
require "mini_magick"
require "stringio"

class OrderMailer < ApplicationMailer
  def order_confirmation(order_item)
    @order_item = order_item
    @customer_email = order_item.customer_email
    @customer_name = order_item.customer_name
    @ticket_code = order_item.ticket_code

    puts "\n@ticket_code: #{@ticket_code.inspect}"

    if @ticket_code.present?
      begin
        qr_code_image = generate_qr_code_image(@ticket_code.uuid)
        attachments.inline["qrcode.png"] = {
          mime_type: "image/png",
          content: qr_code_image.to_blob
        }
      rescue => e
        puts "\nErro ao gerar ou anexar QR Code: #{e.message}"
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
    puts "Aquii 2"
    qrcode = RQRCode::QRCode.new(uuid)
    puts "Aquii 3"
    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      fill: "white",
      module_px_size: 6,
      size: 120
    )
    puts "Aquii 4"

    image = MiniMagick::Image.read(StringIO.new(png.to_s))
    puts "Aquii 5"
    image.format "png"
    puts "Aquii 6"

    image
  end
end
