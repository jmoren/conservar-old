class AddFieldToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :closed_at, :date
  end

  def self.down
    remove_column :tasks, :closed_at
  end
end
