class Item < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
  make_flaggable :important
  belongs_to :user
  belongs_to :collection
  belongs_to :category, :class_name => "ItemCategory", :foreign_key => :item_category_id
  belongs_to :subcategory, :class_name => "ItemCategory", :foreign_key => :item_subcategory_id
  has_many :reports, :dependent => :destroy
  has_many :deteriorations, :through => :reports
  has_many :alerts, :as => :alertable, :dependent => :destroy
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
                  :title, :author, :description,:photo,
                  :item_category_id, :item_subcategory_id,
                  :status, :generic_text_fields_attributes,:generic_text_areas_attributes,
                  :generic_boolean_fields_attributes,:generic_integer_fields_attributes,
                  :generic_float_fields_attributes
  has_attached_file :photo, :styles => {:small => "90x90#",:medium => "150x130#",  :normal => "600x400#"},
                            :path => ":rails_root/public/fotos/items/:code/:style/:basename.:extension",
                            :url => "/fotos/items/:code/:style/:basename.:extension"

  Paperclip.interpolates :code do |attachment, style|
    attachment.instance.code
  end
  scope :by_category, lambda{|category| where(:category => category)}
  scope :by_subcategory, lambda{|subcategory| where(:subcategory => subcategory)}
  scope :by_collection, lambda{|collection| where(:collection => collection)}
  scope :by_author, lambda{|author| where(:author => author)}
  scope :by_status, lambda{|status| where(:status => status)}
  scope :with_deterioration_detected, lambda{|det| joins(:deteriorations,:det_category).where(:name => det)}
  scope :search_by, lambda{|sm,em,y| where('MONTH(created_at) >= ? AND MONTH(created_at) <= ? AND YEAR(created_at) = ?', sm,em,y)}
  validates_presence_of :code, :title, :description, :status
  validates_uniqueness_of :code

  def remove_from_collection
    self.update_attributes(:collection_id => nil )
  end

  def self.search(search)
    if search
      where('title LIKE ? OR code LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
  def has_additional_info?
    !self.generic_text_fields.empty? || !self.generic_text_areas.empty? || !self.generic_text_fields.empty? || !self.generic_float_fields.empty? || !self.generic_boolean_fields.empty? || !self.generic_select_fields.empty?
  end

end

