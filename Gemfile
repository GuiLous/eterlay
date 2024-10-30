source "https://rubygems.org"

gem "rails", "~> 7.2.1"
gem "sprockets-rails"
gem "sqlite3", ">= 1.4"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "graphql"
gem "devise"
gem "devise-jwt"
gem "rack-cors"
gem "apollo_upload_server"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "graphiql-rails"
  gem "web-console"
  gem "solargraph"
  gem "yard"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
