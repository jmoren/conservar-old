class AddClosedAtToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :closed_at, :date
  end

  def self.down
    remove_column :reportss, :closed_at
  end
end
