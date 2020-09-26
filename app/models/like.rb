class Like < ApplicationRecord
  belongs_to :review, counter_cache: :likes_count
  belongs_to :user

  validates_uniqueness_of :review_id, scope: :user_id
end
