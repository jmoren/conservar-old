class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :code
      t.text :comments
      t.text :treatment
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end

