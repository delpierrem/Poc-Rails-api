# frozen_string_literal: true

require 'sequel_utils/base'
require 'sequel_utils/migrator'

module SequelUtils
  class Migration < Base
    include Migrator

    def up(version = nil)
      opts = {}
      opts[:target] = version.to_i if version
      ::Sequel::Migrator.run(db, migrations_dir, opts)
    end

    def down(version = nil)
      opts = {}
      opts[:target] = if version
                        version.to_i
                       else
                        previous_version
                      end

      ::Sequel::Migrator.run(db, migrations_dir, opts)
    end

    class << self
      def up(version = nil)
        new.up(version)
      end

      def down(version = nil)
        new.down(version)
      end
    end

    private

    def previous_version
      migrator.applied_migrations[-2].to_i
    end
  end
end
