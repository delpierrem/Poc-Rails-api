# frozen_string_literal: true

if defined?(Sequel)
  require 'sequel_utils/error'

  namespace :db do
    def config
      require 'sequel_utils/configuration'
      @_config ||= SequelUtils::Configuration.new
    end

    desc 'Create the database defined in ENV["DATABASE_URL"]'
    task :create => :environment do
      config
        .db_connect_without_database
        .execute("CREATE DATABASE #{config.database}")

      warn "[sequel] database '#{config.database}' created"
    end

    desc 'Drop the database defined in ENV["DATABASE_URL"]'
    task :drop => :environment do
      Sequel::DATABASES.each(&:disconnect)

      config
        .db_connect_without_database
        .execute("DROP DATABASE #{config.database}")

      warn "[sequel] database '#{config.database}' dropped"
    end

    desc 'Check if database defined in ENV["DATABASE_URL"] exists'
    task :check => :environment do
      config.db_connect

      warn "[sequel] database '#{config.database}' exists"
    rescue Sequel::DatabaseConnectionError
      abort "[sequel] database '#{config.database}' does not exists"
    end

    desc "Run migrations"
    task :migrate, [:version] => :environment do |_t, args|
      require 'sequel_utils/migration'

      SequelUtils::Migration.up(args[:version])
      Rake::Task['db:schema:dump'].invoke
    end

    desc "Rollback migrations"
    task :rollback, [:version] => :environment do |_t, args|
      require 'sequel_utils/migration'

      SequelUtils::Migration.down(args[:version])
      Rake::Task['db:schema:dump'].invoke
    end

    namespace :schema do

      desc 'Create a db/schema.rb file that can be portably used against any DB supported by Sequel'
      task :dump => :environment do
        require 'sequel_utils/schema'

        SequelUtils::Schema.dump
        Rake::Task['db:schema:dump'].reenable

        warn "[sequel] database schema dumped in db/schema.rb"
      rescue SequelUtils::Error => e
        warn "[sequel] #{e.message}"
      end

      desc 'Load a schema.rb file into the database'
      task :load => :environment do
        require 'sequel_utils/schema'

        SequelUtils::Schema.load_file

        warn "[sequel] database schema loaded from db/schema.rb"
      rescue SequelUtils::Error => e
        warn "[sequel] #{e.message}"
      end
    end

    desc 'Load the seed data from db/seeds.rb'
    task :seed => :environment do
      require 'sequel_utils/seed'

      SequelUtils::Seed.load_file

      warn "[sequel] seeds loaded"
    rescue SequelUtils::Error => e
      warn "[sequel] #{e.message}"
    end

    desc 'Create the database, load the schema, and initialize with the seed data'
    task :setup => %W[db:create db:schema:load db:seed]

    desc "Reset database from db/schema.rb"
    task :reset => %W[db:drop db:setup]
  end

end
