require 'roar/json/json_api'
module Api::V1::Product::Representer
  class Show < Representable::Decorator
    include Representable::JSON
    property :id
    property :title
    property :description
    property :price
    property :image

    collection :reviews
  end
end
