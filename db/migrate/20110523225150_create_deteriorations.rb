class CreateDeteriorations < ActiveRecord::Migration
  def self.up
    create_table :deteriorations do |t|
      t.integer :report_id
      t.string :place
      t.text :description
      t.integer :det_category_id
      t.boolean :fixed

      t.timestamps
    end
  end

  def self.down
    drop_table :deteriorations
  end
end

