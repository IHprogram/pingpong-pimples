FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    association :user
    association :review
  end

  # コメントが空の場合
  trait :invalid do
    content = nil
    content { content }
  end
end
