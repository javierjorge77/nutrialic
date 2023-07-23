class CreateGalleryImages < ActiveRecord::Migration[7.0]
  def change
    create_table :gallery_images do |t|
      t.references :professional, null: false, foreign_key: true
      t.string :url
      t.timestamps
    end
  end
end
