module Api::V1::Product::Contrat
  class Create < Reform::Form
    property :title
    property :description
    property :price
    property :image, virtual: true

    validates :title, presence: true
    validates :description, presence: true
    # validates :image, presence: true
    validates :price, presence: true
    validates :price, numericality: true,
                      unless: proc { |a| a.price.blank? }
  end
end
