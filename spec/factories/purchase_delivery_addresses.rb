FactoryBot.define do
  factory :purchase_delivery_address do
    user_id       { Faker::Number.non_zero_digit }
    item_id       { Faker::Number.non_zero_digit }
    postal_code   { Faker::Base.regexify(/\d{3}-\d{4}/) }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    phone_number  { Faker::Number.number(digits: rand(10..11)) }
    token         {"tok_abcdefghijk00000000000000000"}
  end
end