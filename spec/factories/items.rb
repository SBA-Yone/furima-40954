FactoryBot.define do
  factory :item do
    name                  { Faker::Commerce.product_name }
    info                  { Faker::Lorem.paragraph }
    price                 { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id           { Faker::Number.between(from: 1, to: 10) }
    sales_status_id       { Faker::Number.between(from: 1, to: 10) }
    shipping_fee_id       { Faker::Number.between(from: 1, to: 10) }
    prefecture_id         { Faker::Number.between(from: 1, to: 47) }
    scheduled_delivery_id { Faker::Number.between(from: 1, to: 10) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
