source "https://rubygems.org"
ruby "3.3.3"
gem "rails", "~> 7.2.1"

gem "sprockets-rails"
gem "pg", "~> 1.1"
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
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "pry-rails"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end
