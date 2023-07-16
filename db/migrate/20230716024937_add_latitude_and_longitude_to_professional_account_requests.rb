class AddLatitudeAndLongitudeToProfessionalAccountRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :professional_account_requests, :latitude, :float
    add_column :professional_account_requests, :longitude, :float
  end
end
