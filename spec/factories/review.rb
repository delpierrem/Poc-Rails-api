FactoryBot.define do
  to_create(&:save)
  factory :review do
    rate { Faker::Number.between(1, 5) }
    comment { Faker::Lorem.paragraph }
    product_id { nil }
  end
end
