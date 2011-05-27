class AddFieldsToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :status, :string
    add_column :reports, :start_date, :date
    add_column :reports, :end_date, :date
  end

  def self.down
    remove_column :reports, :end_date
    remove_column :reports, :start_date
    remove_column :reports, :status
  end
end
