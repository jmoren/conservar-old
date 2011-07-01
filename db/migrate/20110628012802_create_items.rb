class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :collection_id
      t.integer :user_id
      t.string :code
      t.string :title
      t.string :author
      t.text :description
      t.integer :item_category_id
      t.integer :item_subcategory_id
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end

