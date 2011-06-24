class Deterioration < ActiveRecord::Base
  belongs_to :report
  belongs_to :det_category
  has_many :tasks
  attr_accessible :report_id, :det_category_id, :place, :description, :fixed, :hours

  def set_fixed
    self.update_attributes!(:fixed => true) unless self.fixed
  end

  def details
    "#{self.id}.#{self.description} "
  end
  def update_status
    if self.remaining_hours == 0.0
      self.update_attributes(:fixed => true )
    else
      self.update_attributes(:fixed => false )
    end
  end
  def update_hours(hours)
    self.hours += hours
    self.save!
  end

  def remaining_hours
    hours = 0.0
    self.tasks.each do |task|
      hours += task.hours
    end
    return hours
  end

  #def to_gjson
  #  self.to_ghash.to_json
  #end

  #def to_ghash
  #  return { :id => self.id,
  #           :name => self.det_category.name,
  #           :series => self.tasks.collect(&:to_ghash)
  #        }
  #end
  #def to_custom_hash
  #  return { :id => self.id,
  #           :fixed => self.fixed,
  #           :category => self.det_category.name,
  #           :description => self.description
  #        }
  #end
  def category
    "#{self.id}.- #{self.det_category.name}"
  end
end

