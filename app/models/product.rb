class Product < Sequel::Model
  include ImageUploader::Attachment.new(:image)
  one_to_many :reviews
end
