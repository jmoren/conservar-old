class CreateGenericTextFields < ActiveRecord::Migration
  def self.up
    create_table :generic_text_fields do |t|
      t.integer :item_id
      t.string :label_attribute
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :generic_text_fields
  end
end

