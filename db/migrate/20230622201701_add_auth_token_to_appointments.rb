class AddAuthTokenToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :authentication_token, :string
    add_index :appointments, :authentication_token
  end
end
