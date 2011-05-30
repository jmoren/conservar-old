class Photo < ActiveRecord::Base
  belongs_to :gallery
  attr_accessible :gallery_id, :description, :image
  has_attached_file :image, :styles => {:small => "80x80#", :normal => "600x400"}
end

