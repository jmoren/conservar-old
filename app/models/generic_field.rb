class GenericField < ActiveRecord::Base
  belongs_to :item_category
  attr_accessible :item_category_id, :name, :field_style
  validates_presence_of :name, :field_style

  STYLES = [['string'],['texto'],['entero'],['boolean'],['float']]
end

