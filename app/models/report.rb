class Report < ActiveRecord::Base
  has_friendly_id :code, :use_slug => true
  has_paper_trail :only => [:code, :conclusion,:closed_at, :budget_tools, :budget_work, :treatment, :comments]
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
                  :item_id, :assigned_to,:conclusion, :budget_work, :budget_tools,
                  :closed_at
  before_save :sanitize_dates
  before_save :check_budgets
  after_create  :report_event
  before_save :update_event
  #scopes
  scope :not_archivied, where(:archived => false)
  scope :archived, where(:archived => true)
  scope :closed, where(:status => "Cerrado")
  scope :with_status, lambda{|status| where(:status => status)}
  scope :search_by, lambda{|sm,em,y| where('MONTH(created_at) >= ? AND MONTH(created_at) <= ? AND YEAR(created_at) = ?', sm,em,y)}

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
    self.update_attributes({:closed_at => Date.today, :status => "Cerrado"})
  end

  def open
    self.update_attributes({:closed_at => nil, :status => "Abierto"})
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
    if !self.end_date.nil?
      Event.create(:title => "Finalizacion del reporte #{self.code}", :activity => "cierre del reporte de conservacion", :start_at => self.end_date.to_time + 8.hours, :end_at => self.end_date.to_time + 17.hours, :user_id => self.user_id, :report_id => self.id)
    end
  end
  def update_event
    if self.changed.include?("end_date")
      if e = Event.find_by_report_id(self.id)
        e.update_dates(self.end_date) if !self.end_date.nil
      end
    end
  end
protected
  def update_dates(date)
    self.update_attributes(:end_date => date)
  end
  def sanitize_dates
    self.start_date = start_date.to_date if self.start_date
    self.end_date = end_date.to_date if self.end_date
  end
  def check_budgets
    self.budget_work = 0 if self.budget_work.nil? || self.budget_work.blank?
    self.budget_tools = 0 if self.budget_tools.nil? || self.budget_tools.blank?
  end
end

