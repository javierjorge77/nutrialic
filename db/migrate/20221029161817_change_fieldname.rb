class ChangeFieldname < ActiveRecord::Migration[7.0]
  def change
    rename_column(:professionals, :speciallity, :branch)
  end
end
