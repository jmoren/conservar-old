class CreateSpecialTasks < ActiveRecord::Migration
  def self.up
    create_table :special_tasks do |t|
      t.integer :collection_id
      t.integer :user_id
      t.text :description
      t.date :date
      t.timestamps
    end
  end

  def self.down
    drop_table :special_tasks
  end
end
