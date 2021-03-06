class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :like_reviews, through: :likes, source: :review
  # あるユーザーがフォローしている他ユーザーとのアソシエーション
  has_many :relationships, foreign_key: 'user_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  # あるユーザーをフォローしている他ユーザーとのアソシエーション
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_one_attached :image

  validates :nickname, presence: true, length: { maximum: 30 }
  validates :self_introduction, length: { maximum: 200 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, format: { with: EMAIL_REGEX }

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は英字と数字の両方を含めて6文字以上のものを設定してください', on: :create

  paginates_per 6

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.nickname = 'ゲストユーザー'
      user.password = 'password12345'
    end
  end

  def follow(other_user)
    # フォローしようとしているユーザーが自分自身でなければそのユーザーをフォローできる。
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    # フォローしていた場合、そのフォローを解除する。
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
