class RemoveNumberAndStatusFromProfessionalAccountRequests < ActiveRecord::Migration[7.0]
  def change
    remove_column :professional_account_requests, :number, :string
    remove_column :professional_account_requests, :status, :string
    change_column :professional_account_requests, :confirmed, :boolean, default: false, null: false
  end
end
