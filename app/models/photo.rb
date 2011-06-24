class Photo < ActiveRecord::Base
  belongs_to :gallery

  attr_accessible :gallery_id, :description, :image
  has_attached_file :image, :styles => {:small => "80x80#", :normal => "600x400#"},
                            :path => ":rails_root/public/fotos/galeria_:gallery_id/:style/:id/:basename.:extension",
                            :url => "/fotos/galeria_:gallery_id/:style/:id/:basename.:extension"

  Paperclip.interpolates :gallery_id do |attachment, style|
    attachment.instance.gallery_id
  end
end

