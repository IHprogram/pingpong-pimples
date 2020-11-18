FactoryBot.define do
  factory :user do
    nickname { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.free_email }
    password = "a12345"
    password { password }
    password_confirmation { password }
  end
end
