class AddItemIdToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :item_id, :integer
  end

  def self.down
    remove_column :reports, :item_id
  end
end
