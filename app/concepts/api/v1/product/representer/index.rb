module Api::V1::Product::Representer
  class Index < Representable::Decorator
    include Representable::JSON

    property :id
    property :title
    property :description
    property :price
    property :image, as: :img
  end
end
