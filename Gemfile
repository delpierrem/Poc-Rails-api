source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'sequel_secure_password'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'api-pagination'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'dotenv-rails', '~> 2.5', require: 'dotenv/rails-now'
gem 'dry-validation'
gem 'jsonapi-rails'
gem 'jwt'
gem 'multi_json'
gem 'pg', '~> 1.1', '>= 1.1.3'
gem 'rack-cors'
gem 'reform-rails'
gem 'roar-jsonapi'
gem 'rswag'

gem 'sequel-rails', '~> 1.0', '>= 1.0.1'
# toolkit for file attachments
gem 'shrine', '~> 2.0'

gem 'trailblazer', '>= 2.0.4', '< 2.1'
gem 'trailblazer-endpoint', github: 'trailblazer/trailblazer-endpoint'
gem 'trailblazer-rails', '>= 1.0.3'
gem 'will_paginate'
# gem 'rack-cors'
group :development do
  gem 'guard-rspec', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails', '~> 0.3.6'
  gem 'rspec-rails', '~> 3.8'
end

group :test do
  gem 'database_cleaner'
end

group :static_analysis do
  # code review
  gem 'pronto'
  # Check if there is any security issues
  gem 'pronto-brakeman', require: false
  # Make your Rubies go faster with this command line tool
  gem 'pronto-fasterer', require: false
  # Detect possible code duplications inviting refactoring.
  gem 'pronto-flay', require: false
  # code smell detector for Ruby
  gem 'pronto-reek', require: false
  # a code metric tool to check the quality of Rails code.
  gem 'pronto-rails_best_practices', require: false
  # Check your code for adherence to the Ruby community style guide.
  gem 'pronto-rubocop', require: false
  # Inspects files in a git diff which need test coverage.
  gem 'pronto-undercover'
  # used with undercover
  gem 'simplecov'
  gem 'simplecov-lcov'
  # syntax validity key repetition and cosmetic problems for yaml
  gem 'pronto-yamllint', require: false
  # gem 'rugged', '0.27.5'
end
