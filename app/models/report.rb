class Report < ActiveRecord::Base
  has_many :deteriorations
  has_many :galleries, :as => :galleryable, :dependent => :destroy
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

  def close
    self.update_attributes!(:status => "Closed")
  end

  def open
    self.update_attributes!(:status => "open")
  end
end

