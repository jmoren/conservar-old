class CreateDetCategories < ActiveRecord::Migration
  def self.up
    create_table :det_categories do |t|
      t.string :name
      t.text :suggestion

      t.timestamps
    end
  end

  def self.down
    drop_table :det_categories
  end
end
