class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string      :name,            null: false
      t.integer     :manufacture_id,  null: false
      t.integer     :type_id,         null: false
      t.integer     :hardness,        null: false
      t.integer     :spin_id,         null: false
      t.integer     :speed_id,        null: false
      t.integer     :price,           null: false
      t.integer     :level_id,        null: false
      t.integer     :evaluation_id,   null: false
      t.text        :content,         null: false
      t.references  :user,            null: false, foreign_key: true
      t.integer     :likes_count
      t.timestamps
    end
  end
end
