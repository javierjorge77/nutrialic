class AddDateAndTimeColumnsToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :date, :date
    change_column :appointments, :time, :time
  end
end
