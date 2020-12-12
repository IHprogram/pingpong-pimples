FactoryBot.define do
  factory :user, aliases: [:follow] do
    nickname { Faker::Lorem.characters(number: 30) }
    email { Faker::Internet.free_email }
    password = 'a12345'
    password { password }
    password_confirmation { password }
    # ユーザーの自己紹介文
    self_introduction { Faker::Lorem.characters(number: 200) }
  end

  trait :profile_image do
    # ユーザーがプロフィール画像を設定している場合
    image { Rack::Test::UploadedFile.new('public/images/user.jpg', 'image/jpg') }
  end
end
