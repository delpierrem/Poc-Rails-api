# frozen_string_literal: true

require 'sequel_utils/base'
require 'sequel_utils/error'

module SequelUtils
  class Seed < Base
    def load_file
      check_file!
      config.db_connect
      load(file)
    end

    class << self
      def load_file
        new.load_file
      end
    end

    private

    def check_file!
      return if file.exist?
      raise Error, "no seeds to load"
    end

    def file
      base_db_dir.join('seeds.rb')
    end
  end
end
