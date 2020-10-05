class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :like_reviews, through: :likes, source: :review
  has_one_attached :image

  validates :nickname, presence: true, length: {maximum: 10}
  validates :self_introduction, length: {maximum: 200}

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers', on: :create

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.nickname = "ゲストユーザー"
      user.password = "password12345"
    end
  end
end
