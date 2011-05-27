class Deterioration < ActiveRecord::Base
  belongs_to :report
  has_many :tasks
  attr_accessible :report_id, :category, :place, :description, :fixed

  def set_fixed
    self.update_attributes!(:fixed => true) unless self.fixed
  end

  def details
    "#{self.id}.#{self.description} "
  end
end

