source "https://rubygems.org"
ruby "3.3.3"
gem "rails", "~> 7.2.1"

gem "sprockets-rails"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "net-protocol"
gem "net-pop", github: "ruby/net-pop"
gem "redis", ">= 4.0.1"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"

group :development, :test do
  gem "brakeman", require: false
  gem "capybara"
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "factory_bot_rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 6.1.0"
  gem "rubocop-rails-omakase", require: false
  gem "selenium-webdriver"
end

group :development do
  gem "web-console"
end

group :test do
  gem "database_cleaner"
  gem "launchy"
  gem "rack_session_access"
  gem "simplecov", require: false
end
