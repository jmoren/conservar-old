class Report < ActiveRecord::Base
  has_many :deteriorations
  has_many :tasks
  accepts_nested_attributes_for :deteriorations, :allow_destroy => true, :reject_if => lambda { |attributes| attributes['place'].blank? || attributes['description'].blank? }
  attr_accessible :code, :comments, :treatment, :deteriorations_attributes, :start_date, :end_date, :status


  def can_close?
    status = true
    self.deteriorations.collect{|d| d.fixed? ? nil : status = false }
    return status
  end

  def closed?
    self.status == "Closed"
  end
  def has_dates?
    self.start_date.nil? && self.end_date.nil?
  end

  def css_advise
    return if self.start_date.nil? || self.end_date.nil?
    remaining = (self.end_date.day - Time.now.day)
    css_class = nil
    if remaining <= 0
      css_class = "alert"
    elsif 0 < remaining && remaining < 3
      css_class = "info"
    elsif remaining >= 3
      css_class = "check"
    end
    return css_class
  end

  def close
    self.update_attributes!(:status => "Closed")
  end
  def open
    self.update_attributes!(:status => "open")
  end
end

