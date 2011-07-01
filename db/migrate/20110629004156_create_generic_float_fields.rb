class CreateGenericFloatFields < ActiveRecord::Migration
  def self.up
    create_table :generic_float_fields do |t|
      t.integer :item_id
      t.string :label
      t.float :content

      t.timestamps
    end
  end

  def self.down
    drop_table :generic_float_fields
  end
end
