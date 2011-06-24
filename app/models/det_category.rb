class DetCategory < ActiveRecord::Base
  has_many :deteriorations
  scope :actives, where(:active => true )
  validates_presence_of :name
  def disable
    self.disable!
  end
  def enable
    self.enable!
  end
  def enable!
    self.update_attributes(:active => true)
  end

  def disable!
    self.update_attributes(:active => false)
  end
end

