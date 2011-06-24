class AddFieldToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :archived, :boolean
  end

  def self.down
    remove_column :reports, :archived
  end
end
