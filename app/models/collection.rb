class Collection < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true
  has_paper_trail :only => [:name, :description]
  belongs_to :user
  has_many :items
  has_many :special_tasks
  attr_accessible :name, :description, :user_id
  validates_presence_of :name, :description
  validates_uniqueness_of :name

  before_destroy :reset_items

  def reset_items
    items.each do |item|
      item.remove_from_collection
    end
  end
  def gral_status
    items = self.items.group(:status).size
  end
  
  def get_all_items
    items
  end
  
  def get_all_items_unresolved
    items.map{|item| item unless item.reports.empty? }
  end
end

