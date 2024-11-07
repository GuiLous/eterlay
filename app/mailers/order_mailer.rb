require "rqrcode"
require "mini_magick"
require "stringio"
require "httparty"

class OrderMailer < ApplicationMailer
  def order_confirmation(order_item)
    @order_item = order_item
    @order_id = order_item.id
    @customer_email = order_item.customer_email
    @customer_name = order_item.customer_name
    @ticket_code = order_item.ticket_code
    @ticket = Ticket.find_by(name: order_item.title)

    if @ticket_code.present?
      begin
        @qr_code_image = generate_qr_code_image(@ticket_code.uuid)
        @qr_code_data_url = "data:image/png;base64,#{Base64.strict_encode64(@qr_code_image.to_blob)}"

        banner_path = Rails.root.join("app", "assets", "images", "banner.jpg")
        @banner_data_url = "data:image/jpeg;base64,#{Base64.strict_encode64(File.read(banner_path))}"

        html = render_to_string(
          template: "tickets/ticket_template",
          layout: false,
          locals: { qr_code_data_url: @qr_code_data_url }
        )

        auth = { username: "5d61ecbe-e27e-4a02-9889-2a2c44be219c", password: "64c88394-7617-4d9d-b836-08e5fa32b080" }

        # Use a service like HTML/CSS to Image API
        response = HTTParty.post("https://hcti.io/v1/image", {
          body: { html: html, width: 300, height: 400 },
          basic_auth: auth
        })

        puts "response: " + response.body.inspect
        if response.success?
          image_url = response.parsed_response["url"]
          image_data = HTTParty.get(image_url).body
          attachments["ingresso.png"] = image_data
        else
          raise "Failed to generate image"
        end
      rescue => e
        puts e.backtrace
      end
    end

    mail(
      to: @order_item.customer_email,
      subject: "Confirmação do seu pedido!"
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
      fill: "#f4f4f4",
      module_px_size: 6,
      size: 520
    )

    image = MiniMagick::Image.read(StringIO.new(png.to_s))
    image.format "png"
    image
  end
end
