FactoryBot.define do
  factory :user, aliases: [:follow] do
    nickname { Faker::Lorem.characters(number: 30) }
    email { Faker::Internet.free_email }
    password = 'a12345'
    password { password }
    password_confirmation { password }
  end
end
