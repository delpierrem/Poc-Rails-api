# frozen_string_literal: true

require 'sequel_rails/storage/abstract'
require 'sequel_rails/storage/postgres'

require 'sequel_utils/error'
require 'sequel_utils/base'
require 'sequel_utils/migrator'

module SequelUtils
  class Schema < Base
    include Migrator

    def dump
      check_directory!
      db.extension :schema_dumper

      File.open file, 'w' do |file|
        file << db.dump_schema_migration(:same_db => true)
        file << storage.schema_information_dump(migrator, false)
      end
    end

    def load_file
      check_file!
      require 'sequel/extensions/migration'
      load(file)
      ::Sequel::Migration.descendants.each { |m| m.apply(db, :up) }
    rescue Sequel::DatabaseError => e
      if e.message.start_with?('PG::DuplicateTable')
        raise Error, "#{config.database} schema already loaded"
      else
        raise Error, e.message
      end
    end

    class << self
      def dump
        new.dump
      end

      def load_file
        new.load_file
      end
    end

    private

    def check_directory!
      return if base_db_dir.exist?
      raise Error, "The #{base_db_dir.basename} directory doesn't exist, please create it."
    end

    def check_file!
      return if file.exist?
      raise Error, "#{file.basename} doesn't exist yet. Run 'rake db:migrate' to create it, then try again."
    end

    def storage
      SequelRails::Storage::Postgres.new(url: config.url)
    end


    def file
      base_db_dir.join('schema.rb')
    end
  end
end