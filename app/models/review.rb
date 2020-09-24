class Review < ApplicationRecord
  has_many :comments
  has_many :likes, dependent: :destroy
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :manufacture
  belongs_to_active_hash :type
  belongs_to_active_hash :spin
  belongs_to_active_hash :speed
  belongs_to_active_hash :control
  belongs_to_active_hash :evaluation

  HALF_WIDTH_NUMBER_REGEX = /\A[0-9]+\z/.freeze

  with_options presence: true do
    validates :image
    validates :name
    validates :manufacture_id, numericality: { other_than: 1, message: 'Select' }
    validates :type_id,        numericality: { other_than: 1, message: 'Select' }
    validates :spin_id,        numericality: { other_than: 1, message: 'Select' }
    validates :speed_id,       numericality: { other_than: 1, message: 'Select' }
    validates :control_id,     numericality: { other_than: 1, message: 'Select' }
    validates :price,          format: { with: HALF_WIDTH_NUMBER_REGEX, message: 'Half-width number' }
    validates :evaluation_id,  numericality: { other_than: 1, message: 'Select' }
    validates :content
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
