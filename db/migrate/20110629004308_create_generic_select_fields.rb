class CreateGenericSelectFields < ActiveRecord::Migration
  def self.up
    create_table :generic_select_fields do |t|
      t.integer :item_id
      t.string :label
      t.string :content
      t.string :options

      t.timestamps
    end
  end

  def self.down
    drop_table :generic_select_fields
  end
end
