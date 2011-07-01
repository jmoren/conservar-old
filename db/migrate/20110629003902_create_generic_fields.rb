class CreateGenericFields < ActiveRecord::Migration
  def self.up
    create_table :generic_fields do |t|
      t.integer :item_category_id
      t.string :name
      t.string :field_style
      t.timestamps
    end
  end

  def self.down
    drop_table :generic_fields
  end
end

