class GenericField < ActiveRecord::Base
  has_paper_trail :only => [:name, :field_style]
  belongs_to :item_category
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

