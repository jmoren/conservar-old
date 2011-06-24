class CreateInstitutions < ActiveRecord::Migration
  def self.up
    create_table :institutions do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :city
      t.string :country
      t.string :email
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.string :zip

      t.timestamps
    end
  end

  def self.down
    drop_table :institutions
  end
end
