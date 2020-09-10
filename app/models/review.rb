class Review < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :manufacture
  belongs_to_active_hash :type
  belongs_to_active_hash :spin
  belongs_to_active_hash :speed
  belongs_to_active_hash :level
  belongs_to_active_hash :evaluation
end
