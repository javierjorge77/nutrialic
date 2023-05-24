class CreateProfessionals < ActiveRecord::Migration[7.0]
  def change
    create_table :professionals do |t|
      t.string :speciallity
      t.string :adress
      t.string :diploma
      t.integer :first_cost
      t.integer :follow_cost
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
