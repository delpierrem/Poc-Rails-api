# frozen_string_literal: true

require 'sequel_utils/configuration'

SequelUtils.configure do |config|
  # Init connection to database engine.
  # Do not raise when database do not exist for db:create task.
  # The error will raise on first model call.
  config.db_connect
end
