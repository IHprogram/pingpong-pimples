class Review < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :user
  has_one_attached :image
end
