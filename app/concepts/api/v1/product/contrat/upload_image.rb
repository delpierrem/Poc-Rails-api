module Api::V1::Product::Contrat
  class UploadImage < Reform::Form
    include ImageUploader::Attachment.new(:image)
    property :image, virtual: true
    validates :image, presence: true
  end
end
