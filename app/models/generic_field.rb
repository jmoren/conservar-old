class GenericField < ActiveRecord::Base
  has_paper_trail :only => [:name, :field_style]
  belongs_to :item_category
  has_many :generic_text_field
  has_many :generic_text_area
  has_many :generic_boolean_field
  has_many :generic_integer_field
  has_many :generic_float_field
  attr_accessible :item_category_id, :name, :field_style
  validates_presence_of :name
  STYLES = [['string'],['texto'],['entero'],['boolean'],['float']]

  validate :field_taken
  validates_presence_of :name
  def field_taken
    item_category = ItemCategory.find(self.item_category_id)
    if item_category.generic_fields.find_by_name(self.name)
      errors.add(:name,"ya existe en esta categoria")
    end
  end
end

