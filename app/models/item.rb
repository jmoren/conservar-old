class Item < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
  belongs_to :user
  belongs_to :collection
  belongs_to :category, :class_name => "ItemCategory", :foreign_key => :item_category_id
  belongs_to :subcategory, :class_name => "ItemCategory", :foreign_key => :item_subcategory_id
  has_many :reports, :dependent => :destroy
  has_many :deteriorations, :through => :reports
  #generic fields
  has_many :generic_text_fields, :dependent => :destroy
  has_many :generic_text_areas, :dependent => :destroy
  has_many :generic_float_fields, :dependent => :destroy
  has_many :generic_integer_fields, :dependent => :destroy
  has_many :generic_boolean_fields, :dependent => :destroy
  has_many :generic_select_fields, :dependent => :destroy
  accepts_nested_attributes_for :generic_text_fields,:generic_text_areas,:generic_boolean_fields,
                                :generic_integer_fields, :generic_float_fields, :allow_destroy => true

  attr_accessible :collection_id,:user_id, :code,
                  :title, :author, :description,
                  :item_category_id, :item_subcategory_id,
                  :status, :generic_text_fields_attributes,:generic_text_areas_attributes,
                  :generic_boolean_fields_attributes,:generic_integer_fields_attributes,
                  :generic_float_fields_attributes

  scope :by_category, lambda{|category| where(:category => category)}
  scope :by_subcategory, lambda{|subcategory| where(:subcategory => subcategory)}
  scope :by_collection, lambda{|collection| where(:collection => collection)}
  scope :by_collection, lambda{|author| where(:author => author)}
  scope :by_collection, lambda{|status| where(:status => status)}
  scope :with_deterioration_detected, lambda{|det| joins(:deteriorations,:det_category).where(:name => det)}
  validates_presence_of :code, :title, :description, :status
  validates_presence_of :category, :subcategory, :on => :create
  validates_uniqueness_of :code

  def remove_from_collection
    self.update_attributes(:collection_id => nil )
  end
  def self.search(search)
    if search
      where('title LIKE ? OR code LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end

