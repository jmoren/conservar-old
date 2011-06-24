class AddHoursToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :hours, :float, :default => 1.0
    add_column  :reports, :hours, :float, :default => 0.0
    add_column  :deteriorations, :hours, :float, :default => 0.0
  end

  def self.down
    remove_column :tasks, :hours
    remove_column :reports, :hours
    remove_column :deteriorations, :hours
  end
end

