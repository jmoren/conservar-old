class CreateHistoryChanges < ActiveRecord::Migration
  def self.up
    create_table :history_changes do |t|
      t.integer :history_id
      t.string :field_change
      t.text :content_change

      t.timestamps
    end
  end

  def self.down
    drop_table :history_changes
  end
end
