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

  def follow(other_user)
    # フォローしようとしているユーザーが自分自身でなければそのユーザーをフォローできる。
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    # フォローしていた場合、そのフォローを解除する。
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
end
