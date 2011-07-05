class Collection < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true
  belongs_to :user
  has_many :items
  attr_accessible :name, :description, :user_id
  validates_presence_of :name, :description
  validates_uniqueness_of :name

  def gral_status
    items = self.items.group(:status).size
  end
end

