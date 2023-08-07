class AddFinalizadaToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :finalizada, :boolean, default: false
  end
end
