class AddConfirmedToProfessionals < ActiveRecord::Migration[7.0]
  def change
    add_column :professionals, :confirmed, :boolean, default: false, null: false
  end
end
