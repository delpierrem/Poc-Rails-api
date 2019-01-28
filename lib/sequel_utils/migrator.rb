# frozen_string_literal: true

require 'active_support/concern'

module SequelUtils
  module Migrator
    extend ActiveSupport::Concern

    private

    def migrator
      @_migrator ||= begin
        migrator_class = ::Sequel::Migrator.send(:migrator_class, migrations_dir)
        migrator_class.new(db, migrations_dir)
      end
    end

    def migrations_dir
      base_db_dir.join('migrate')
    end
  end
end