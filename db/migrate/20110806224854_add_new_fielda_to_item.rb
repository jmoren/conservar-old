class AddNewFieldaToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :featured, :boolean, :default => false
    add_column :items, :remote_site, :string
  end

  def self.down
    remove_column :items, :remote_site
    remove_column :items, :featured
  end
end

