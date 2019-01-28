50.times do |times|
  title = Faker::Commerce.product_name
  product = Product::Create.call(
    {
      product: {
        title: title,
        description: Faker::Lorem.paragraph(2, true, 4),
        img_url: Faker::Placeholdit.image("300x300", 'jpg', 'f2f2f2', '41B883', "#{title}"),
        price: Faker::Number.between(1,202)
      }
    }
  )

  10.times do
    review = Review.create(
      rate: Faker::Number.between(1, 5),
      comment: Faker::Lorem.paragraph,
      product: product['model']
    )
  end
  puts "#{times + 1 }/50"
end
