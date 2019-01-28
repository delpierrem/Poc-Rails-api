# frozen_string_literal: true

require 'sequel_utils/configuration'

module SequelUtils
  class Base
    def initialize
      @config = Configuration.new
    end

    attr_reader :config

    private

    def db
      @_db ||= config.db_connect
    end

    def base_db_dir
      Rails.root.join('db')
    end
  end
end
