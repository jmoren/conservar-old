class GenericIntegerField < ActiveRecord::Base
  belongs_to :item
  belongs_to :generic_field
end

