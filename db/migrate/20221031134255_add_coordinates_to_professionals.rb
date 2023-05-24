class AddCoordinatesToProfessionals < ActiveRecord::Migration[7.0]
  def change
    add_column :professionals, :latitude, :float
    add_column :professionals, :longitude, :float
  end
end
