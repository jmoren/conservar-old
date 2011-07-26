class AddDayToAlert < ActiveRecord::Migration
  def self.up
    add_column :alerts, :day, :string
  end

  def self.down
    remove_column :alerts, :day
  end
end
