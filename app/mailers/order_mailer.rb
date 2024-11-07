require "rqrcode"
require "mini_magick"
require "stringio"

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

        tmp_html_path = Rails.root.join("tmp", "ticket_template.html")
        File.open(tmp_html_path, "w") { |file| file.write(html) }

        output_path = Rails.root.join("public", "ticket_image_#{@order_id}.png")
        wkhtmltoimage_options = [
          "--width 500",
          "--height 600",
          "--quality 40",
          "--enable-local-file-access",
          "--disable-smart-width",
          "--no-stop-slow-scripts"
        ].join(" ")

        wkhtmltoimage_path = Rails.env.production? ? "/app/bin/wkhtmltoimage" : "wkhtmltoimage"
        command = "#{wkhtmltoimage_path} #{wkhtmltoimage_options} #{tmp_html_path} #{output_path}"

        system(command)

        attachments["ingresso.png"] = File.read(output_path)

        File.delete(tmp_html_path) if File.exist?(tmp_html_path)
        File.delete(output_path) if File.exist?(output_path)
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
