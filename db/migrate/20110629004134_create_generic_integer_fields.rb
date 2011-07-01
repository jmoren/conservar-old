class CreateGenericIntegerFields < ActiveRecord::Migration
  def self.up
    create_table :generic_integer_fields do |t|
      t.integer :item_id
      t.string :label
      t.integer :content

      t.timestamps
    end
  end

  def self.down
    drop_table :generic_integer_fields
  end
end
