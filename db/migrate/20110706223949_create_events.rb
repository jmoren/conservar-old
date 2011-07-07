class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.text :activity
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :all_day
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
