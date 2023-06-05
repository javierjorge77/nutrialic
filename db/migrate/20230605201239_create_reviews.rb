class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :professional_id
      t.integer :user_id
      t.text :comment
      t.float :score
      t.timestamps
    end
  end
end
