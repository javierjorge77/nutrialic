class AddAprobadoToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :aprobado, :boolean
    change_column_default :appointments, :aprobado, false
  end
end
