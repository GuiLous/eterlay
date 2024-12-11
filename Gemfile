source "https://rubygems.org"

ruby "3.3.5"

gem "rails", "~> 8.0.0"
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
gem "rqrcode"
gem "mini_magick"
gem "chunky_png"
gem "sprockets-rails"
gem "imgkit"
gem "pg"
gem "httparty"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "dotenv-rails"
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
