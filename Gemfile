source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.3"

gem "coffee-rails", "~> 4.2"
gem "grape"
gem "grape-active_model_serializers"
gem "grape-swagger"
gem "grape-swagger-rails"
gem "grape_fast_jsonapi"
gem "jbuilder", "~> 2.5"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.1"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

gem "bootsnap", ">= 1.1.0", require: false

gem "devise"
gem "devise_lastseenable"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem "annotate"
  gem "awesome_print"
  gem "brakeman", require: false
  gem "bullet"
  gem "haml-lint", require: false
  gem "letter_opener_web"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "overcommit", require: false
  gem "pry-rails"
  gem "rubocop", require: false
  gem "ruby_css_lint", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end

# Windows does not include zone info files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
