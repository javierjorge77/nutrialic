class AddUsernameToProfessionals < ActiveRecord::Migration[7.0]
  def change
    add_column :professionals, :username, :string
  end
end
