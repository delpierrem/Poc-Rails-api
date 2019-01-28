require 'roar/json/json_api'
class ProductRepresenter < Roar::Decorator
  include Roar::JSON::JSONAPI.resource :products

  # TODO: include link helper for representers
  BASE_URL = 'http://localhost:3000/'

  link :self, toplevel: true do
    "#{base_url}products?page=#{represented.current_page}"
  end

  link :next, toplevel: true do
    "#{base_url}products?page=#{represented.next_page}" if \
    represented.next_page
  end

  link :last, toplevel: true do
    "#{base_url}products?page=#{represented.total_pages}"
  end

  link :prev, toplevel: true do
    "#{base_url}products?page=#{represented.previous_page}" if \
    represented.previous_page
  end

  attributes do
    property :id
    property :title
    property :description
    property :price
    property :image
  end

  has_many :reviews do
    type :reviews
    attributes do
      property :id
      property :rate
    end
    relationship do
      link(:self) { "/product/#{represented.id}/reviews/" }
    end
  end
end
