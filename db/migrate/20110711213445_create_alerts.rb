class CreateAlerts < ActiveRecord::Migration
  def self.up
    create_table :alerts do |t|
      t.string :alertable_type
      t.integer :alertable_id
      t.text :message
      t.string :frequency
      t.integer :custom
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :alerts
  end
end
