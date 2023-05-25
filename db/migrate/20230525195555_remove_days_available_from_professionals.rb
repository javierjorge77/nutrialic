class RemoveDaysAvailableFromProfessionals < ActiveRecord::Migration[7.0]
  def change
    remove_column :professionals, :daysAvailable, :string
  end
end
