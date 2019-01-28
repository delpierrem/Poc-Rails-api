require 'roar/json/json_api'

class ErrorRepresenter < Representable::Decorator
  include Representable::JSON::Hash
end
