class AddFieldsToProfessionalAccountRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :professional_account_requests, :branch, :string
    add_column :professional_account_requests, :adress, :string
    add_column :professional_account_requests, :diploma, :string
    add_column :professional_account_requests, :first_cost, :integer
    add_column :professional_account_requests, :follow_cost, :integer
    add_column :professional_account_requests, :startAttendingTime, :time
    add_column :professional_account_requests, :endAttendingTime, :time
    add_column :professional_account_requests, :username, :string
    add_column :professional_account_requests, :confirmed, :boolean
  end
end
