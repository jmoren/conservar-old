class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :username
      t.string  :email
      t.string  :password_hash
      t.string  :password_salt
      t.string  :name
      t.string  :lastname
      t.boolean :enabled, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

