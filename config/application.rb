require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"

require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ministack
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.autoload_paths << "#{Rails.root}/app/uploarders"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Configure whether database's rake tasks will be loaded or not.
    #
    # If passed a String or Symbol, this will replace the `db:` namespace for
    # the database's Rake tasks.
    #
    # ex: config.sequel.load_database_tasks = :sequel
    #     will results in `rake db:migrate` to become `rake sequel:migrate`
    #
    # Defaults to true
    config.sequel.load_database_tasks = false
    config.trailblazer.enable_loader = false
    # This setting disabled the automatic connect after Rails init
    config.sequel.skip_connect = true
    # Sequel::Database.extension :pagination
  end
end
