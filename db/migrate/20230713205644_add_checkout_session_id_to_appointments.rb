class AddCheckoutSessionIdToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :checkout_session_id, :string
  end
end
