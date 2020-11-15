# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "rails", "~> 6.0.3", ">= 6.0.3.3"
gem "puma", "~> 4.1"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 4.0"
gem "jbuilder", "~> 2.7"
gem "bootsnap", ">= 1.4.2", require: false

# Not default
gem "pg", ">= 0.18", "< 2.0"
gem "rails-i18n", "~> 6.0.0"
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
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # Not default
  gem "slim_lint"
  gem "html2slim"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
