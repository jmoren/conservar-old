class AddReportIdToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :report_id, :integer
  end

  def self.down
    remove_column :events, :report_id
  end
end
