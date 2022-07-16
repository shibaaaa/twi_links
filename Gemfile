# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

gem "rails", "7.0.3.1"
gem "puma", "~> 5.6"
gem "sass-rails"
gem "webpacker"
gem "jbuilder"
gem "bootsnap", require: false

# Not default
gem "pg"
gem "rails-i18n"
gem "slim-rails"
gem "devise"
gem "devise-i18n"
gem "omniauth"
gem "omniauth-twitter"
gem "omniauth-rails_csrf_protection"
gem "dotenv-rails"
gem "twitter"
gem "mechanize"
gem "bulma-rails"
gem "font-awesome-sass"
gem "kaminari"
gem "parallel"
gem "meta-tags"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]

  # Not default
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "webmock"
  gem "vcr"
  gem "pry-byebug", ">= 3.9.0"
  gem "dead_end"
end

group :development do
  gem "web-console"
  gem "listen"
  gem "spring"

  # Not default
  gem "slim_lint"
  gem "html2slim"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "bullet"
end
