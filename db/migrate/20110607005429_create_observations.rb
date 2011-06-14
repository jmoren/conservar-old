class CreateObservations < ActiveRecord::Migration
  def self.up
    create_table :observations do |t|
      t.integer :report_id
      t.string :category
      t.text :body
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :observations
  end
end
