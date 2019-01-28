require 'roar/json/json_api'

class ReviewRepresenter < Roar::Decorator
  include Roar::JSON::JSONAPI.resource :reviews
  # resource object links

  BASE_URL = 'http://localhost:3000/products'

  link(:self) { "#{base_url}/#{represented.product_id}/#{represented.id}" }

  attributes do
    property :rate
    property :comment
  end
end
