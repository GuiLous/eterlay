require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false

  config.eager_load = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  config.assets.compile = false

  config.active_storage.service = :local

  config.force_ssl = true

  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  config.log_tags = [ :request_id ]

  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",     # ou seu servidor SMTP
    port:                 587,
    domain:               "gmail.com",        # seu domínio
    user_name:            ENV["GMAIL_USER"],
    password:             ENV["GMAIL_PASSWORD"],
    authentication:       "plain",
    enable_starttls_auto: true
  }

  config.action_mailer.default_url_options = { host: ENV["HOST"], port: 3000, protocol: "https" }

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.report_deprecations = false

  config.active_record.dump_schema_after_migration = false
end
