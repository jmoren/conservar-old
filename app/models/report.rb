class Report < ActiveRecord::Base
  belongs_to :user
  has_many :deteriorations, :dependent=> :destroy
  has_many :galleries, :as => :galleryable, :dependent => :destroy
  has_many :tasks, :dependent=> :destroy
  has_many :observations, :dependent=> :destroy
  accepts_nested_attributes_for :deteriorations, :allow_destroy => true, :reject_if => lambda { |attributes| attributes['place'].blank? || attributes['description'].blank? }
  attr_accessible :code, :comments, :treatment, :deteriorations_attributes, :start_date, :end_date, :status,:user_id
  #validates_uniqueness_of :code
  before_save :generate_code

  def to_param
    "#{self.code}"
  end
  def can_close?
    status = true
    self.deteriorations.collect{|d| d.fixed? ? nil : status = false }
    return status
  end

  def closed?
    self.status == "Closed"
  end

  def has_dates?
    !self.start_date.nil? or !self.end_date.nil?
  end

  def close
    self.update_attributes!(:status => "Closed")
  end

  def open
    self.update_attributes!(:status => "open")
  end

  protected
  def generate_code
    random = ""
    6.times{ random << SecureRandom.random_number(6).to_s}
    self.code = "RE"+ random
  end
end

