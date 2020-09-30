class AddVideoToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :video, :string
  end
end
