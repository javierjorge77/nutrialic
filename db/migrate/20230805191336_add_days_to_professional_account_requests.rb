class AddDaysToProfessionalAccountRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :professional_account_requests, :days, :string
  end
end
