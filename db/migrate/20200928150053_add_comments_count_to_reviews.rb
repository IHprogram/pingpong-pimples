class AddCommentsCountToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :comments_count, :integer
  end
end
