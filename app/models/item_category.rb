class ItemCategory < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true
  has_many :items
  has_many :item_categories
  belongs_to :item_category
  has_many :generic_fields
  scope :subcategories, lambda{|category| where(:item_category_id => category) }
  scope :categories, where(:item_category_id => nil)
  scope :all_subcategories, where('item_category_id is not null')
  validates_presence_of :name

  def active?
    self.active
  end

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

  def empty?
    items.empty?
  end

  def parent
    item_category
  end
end

