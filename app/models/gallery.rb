class Gallery < ActiveRecord::Base
  has_paper_trail :only => [:description]
  belongs_to :user
  belongs_to :galleryable, :polymorphic => true
  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos, :allow_destroy => true
  attr_accessible :galleryable_id, :galleryable_type, :description,:photos_attributes,:user_id

  def title
    "Galeria ##{self.id}"
  end
end

