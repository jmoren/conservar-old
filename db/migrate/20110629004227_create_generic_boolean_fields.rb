class CreateGenericBooleanFields < ActiveRecord::Migration
  def self.up
    create_table :generic_boolean_fields do |t|
      t.integer :item_id
      t.string :label_attribute
      t.boolean :content

      t.timestamps
    end
  end

  def self.down
    drop_table :generic_boolean_fields
  end
end

