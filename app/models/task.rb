class Task < ActiveRecord::Base
  has_paper_trail :only => [:description, :hours]
  belongs_to :user
  belongs_to :report
  belongs_to :deterioration
  has_many :tools, :dependent => :destroy
  has_many :galleries, :as => :galleryable
  accepts_nested_attributes_for :tools, :allow_destroy => true, :reject_if => lambda { |attributes| attributes['category'].blank? || attributes['description'].blank? }
  attr_accessible :report_id, :deterioration_id, :description, :tools_attributes,:user_id, :hours
  validates_numericality_of :hours, :allow_blank => true
  validates_presence_of :description, :deterioration_id

  before_save :check_status
  scope :closed, where('closed_at is not null')
  scope :open, where(:closed_at => nil)

  def check_status
    self.closed_at = self.hours == 0 ? Time.now : nil
  end

  def to_gjson
    self.to_ghash.to_json
  end

  def to_ghash
    #
    return { :name => "task " + self.id.to_s,
             :start => self.created_at.strftime('%a %b %d %Y'),
             :end => self.closed_at.try(:strftime,'%a %b %d %Y'),
             :color => "#f1f1f1"
          }
  end
end

