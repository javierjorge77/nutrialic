class AddScheduleToProfessionals < ActiveRecord::Migration[7.0]
  def change
    add_column :professionals, :startAttendingTime, :time
    add_column :professionals, :endAttendingTime, :time
    add_column :professionals, :daysAvailable, :string
  end
end
