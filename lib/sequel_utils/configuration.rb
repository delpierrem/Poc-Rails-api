# frozen_string_literal: true

module SequelUtils
  def configure(&block)
    yield Configuration.new
  end
  module_function :configure

  class Configuration
    attr_reader :url, :db

    def initialize(url = nil)
      @url = url || ENV['DATABASE_URL']
      @db = build_database_configuration
    end

    def db_connect_without_database
      Sequel.connect(db_without_database_name)
    end

    def db_connect(raise_on_db_connection_error: true)
      Sequel::Model.db = Sequel.connect(db)
    rescue Sequel::DatabaseConnectionError => e
      raise e if raise_on_db_connection_error
    end

    def method_missing(method_name, *args, &block)
      return @db[method_name] if respond_to_missing?(method_name)
      super
    end

    def respond_to_missing?(method_name, include_private = false)
      @db[method_name].present? || super
    end

    private

    def db_without_database_name
      conf = db.dup
      conf.delete(:database)
      conf
    end

    def build_database_configuration
      check_url!
      uri = URI.parse(url)
      {
        adapter: uri.scheme,
        host: uri.host,
        user: uri.user,
        password: uri.password,
        port: uri.port,
        database: uri.path.gsub('/', ''),
      }.compact
    end

    def check_url!
      return unless url.blank?
      raise ArgumentError, <<~ERROR.strip_heredoc
        [sequel] missing DATABASE_URL environment variable.
      ERROR
    end
  end
end
