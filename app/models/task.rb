class Task < ActiveRecord::Base
  belongs_to :report
  belongs_to :deterioration
  has_many :tools, :dependent => :destroy
  accepts_nested_attributes_for :tools, :allow_destroy => true, :reject_if => lambda { |attributes| attributes['category'].blank? || attributes['description'].blank? }
  attr_accessible :report_id, :deterioration_id, :description, :tools_attributes
end

