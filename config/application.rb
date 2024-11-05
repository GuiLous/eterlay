require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Eterlay
  class Application < Rails::Application
    config.active_record.query_log_tags_enabled = true
    config.active_record.query_log_tags = [
      :application, :controller, :action, :job,
      current_graphql_operation: -> { GraphQL::Current.operation_name },
      current_graphql_field: -> { GraphQL::Current.field&.path },
      current_dataloader_source: -> { GraphQL::Current.dataloader_source_class }
    ]
    config.load_defaults 7.2
    config.autoload_lib(ignore: %w[assets tasks])
    config.api_only = false
    config.public_file_server.enabled = true
    config.debug_exception_response_format = :api
    config.autoload_paths += %W[#{config.root}/app/services]
    config.generators do |g|
      g.template_engine nil
    end
  end
end
