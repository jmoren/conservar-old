class Report < ActiveRecord::Base
  has_friendly_id :code, :use_slug => true
  belongs_to :user
  belongs_to :assigned, :class_name => "User", :foreign_key => :assigned_to
  belongs_to :item
  has_many :deteriorations, :dependent=> :destroy
  has_many :galleries, :as => :galleryable, :dependent => :destroy
  has_many :alerts, :as => :alertable, :dependent => :destroy
  has_many :tasks, :dependent=> :destroy
  has_many :observations, :dependent=> :destroy
  accepts_nested_attributes_for :deteriorations, :allow_destroy => true, :reject_if => lambda { |attributes| attributes['place'].blank? || attributes['description'].blank? }

  attr_accessible :code, :comments, :treatment, :deteriorations_attributes,
                  :start_date, :end_date, :status,:user_id,:hours,:archived,
                  :item_id, :assigned_to
  before_save :sanitize_dates, :report_event

  #scopes
  scope :not_archivied, where(:archived => false)
  scope :archived, where(:archived => true)
  scope :closed, where(:status => "Cerrado")
  scope :with_status, lambda{|status| where(:status => status)}


  def can_close?
    status = true
    self.deteriorations.collect{|d| d.fixed? ? nil : status = false }
    return status
  end

  def closed?
    self.status == "Cerrado"
  end

  def has_dates?
    !self.start_date.nil? or !self.end_date.nil?
  end

  def close
    self.update_attributes!(:status => "Cerrado")
  end

  def open
    self.update_attributes!(:status => "Abierto")
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
  def generate_code
    s = ""
    3.times {s << rand(9).to_s}
    self.code = "RC" + s + " " + self.item.code
  end
  def report_event
    if !self.end_date.nil?  && self.end_date_changed?
      Event.create(:title => "Fin del reporte #{self.code}", :activity => "cierre del reporte de conservacion", :start_at => self.end_date.to_time + 8.hours, :end_at => self.end_date.to_time + 17.hours, :user_id => self.user_id)
    end
  end
protected
  def sanitize_dates
    self.start_date = start_date.to_date if self.start_date
    self.end_date = end_date.to_date if self.end_date
  end
end

