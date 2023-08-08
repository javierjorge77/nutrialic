class CreateAboutSections < ActiveRecord::Migration[7.0]
  def change
    create_table :about_sections do |t|
      t.references :professional, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
