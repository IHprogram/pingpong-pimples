FactoryBot.define do
  factory :review do
    name { Faker::Name.name }
    manufacture_id { 2 }
    type_id { 2 }
    hardness_id { 2 }
    spin_id { 2 }
    speed_id { 2 }
    control_id { 2 }
    evaluation_id { 2 }
    price { Faker::Number.between(from: 1000, to: 20_000) }
    content { Faker::Lorem.sentence }
    association :user
  end
end
