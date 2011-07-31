class Institution < ActiveRecord::Base
  attr_accessible :name, :address, :phone, :email, :city, :country, :zip, :image
  has_attached_file :image, :styles => {:small => "120x120#"},
                    :path => ":rails_root/public/fotos/institution/:style/:id/:basename.:extension",
                    :url => "/fotos/institution/:style/:id/:basename.:extension"
  validates  :name, :address, :phone, :email, :city, :country, :zip, :presence => true
  validates_uniqueness_of :name

end

