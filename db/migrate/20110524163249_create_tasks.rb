class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer :report_id
      t.integer :deterioration_id
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
