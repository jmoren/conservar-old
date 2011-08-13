class AddRemoteImageUrlToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :remote_image, :string
  end

  def self.down
    remove_column :items, :remote_image
  end
end
