class CreateTools < ActiveRecord::Migration
  def self.up
    create_table :tools do |t|
      t.integer :task_id
      t.string :category
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :tools
  end
end
