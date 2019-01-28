FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'azerty' }
    password_confirmation { 'azerty' }
  end
end
