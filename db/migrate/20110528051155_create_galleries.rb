class CreateGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      t.integer :galleryable_id
      t.string :galleryable_type
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :galleries
  end
end
