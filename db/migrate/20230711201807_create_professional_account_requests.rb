class CreateProfessionalAccountRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :professional_account_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :number
      t.string :status

      t.timestamps
    end
  end
end
