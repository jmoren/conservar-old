class AddFieldToDetCategory < ActiveRecord::Migration
  def self.up
    add_column :det_categories, :active, :boolean, :default => true
  end

  def self.down
    remove_column :det_categories, :active
  end
end
