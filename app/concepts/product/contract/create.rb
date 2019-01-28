require 'dry/validation/compat/form'
module Product::Contract
  class Create < Reform::Form
    include Dry

    property :title
    property :description
    # property :image, virtual: true
    property :price

    validation do
      required(:title).filled
      # required(:image).filled
      required(:description).filled
      required(:price).filled
    end
  end
end
