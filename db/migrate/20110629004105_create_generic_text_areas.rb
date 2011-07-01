class CreateGenericTextAreas < ActiveRecord::Migration
  def self.up
    create_table :generic_text_areas do |t|
      t.integer :item_id
      t.string :label
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :generic_text_areas
  end
end
