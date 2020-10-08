FactoryBot.define do
  factory :review do
    name { Faker::Lorem.words }
    manufacture { Manufacture.all.sample }
    type { Type.all.sample }
    hardness { Hardness.all.sample }
    spin { Spin.all.sample }
    speed { Speed.all.sample }
    control { Control.all.sample }
    price { Faker::Number.between(from: 1000, to: 20_000) }
    evaluation { Evaluation.all.sample }
    content { Faker::Lorem.sentence }
    association :user
  end
end
