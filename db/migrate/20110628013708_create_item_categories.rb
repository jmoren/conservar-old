class CreateItemCategories < ActiveRecord::Migration
  def self.up
    create_table :item_categories do |t|
      t.string  :name
      t.integer :item_category_id, :default => nil
      t.boolean :active, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :item_categories
  end
end

