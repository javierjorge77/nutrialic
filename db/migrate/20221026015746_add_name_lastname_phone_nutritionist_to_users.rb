class AddNameLastnamePhoneNutritionistToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nutritionist, :boolean
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :phone, :string
  end
end
