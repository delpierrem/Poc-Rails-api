FactoryBot.define do
  to_create(&:save)

  factory :product do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph(2, true, 4) }
    image { File.open('public/test/files/gg.png') }
    price { 25.50 }
  end

  factory :product_without_image, class: Product do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph(2, true, 4) }
    price { 25.50 }
  end
end
