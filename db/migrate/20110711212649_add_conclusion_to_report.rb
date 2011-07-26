class AddConclusionToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :conclusion, :text
    add_column :reports, :budget_tools, :float
    add_column :reports, :budget_work, :float
    add_column :reports, :assigned_to, :integer
  end

  def self.down
    remove_column :reports, :budget_work
    remove_column :reports, :budget_tools
    remove_column :reports, :conclusion
    remove_column :reports, :assigned_to
  end
end
