class AddOnlineReunionIdToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :online_reunion_id, :string
  end
end
