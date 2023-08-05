class AddDaysToProfessionals < ActiveRecord::Migration[7.0]
  def change
    add_column :professionals, :days, :string
  end
end
