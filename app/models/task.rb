class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :report
  belongs_to :deterioration
  has_many :tools, :dependent => :destroy
  has_many :galleries, :as => :galleryable
  accepts_nested_attributes_for :tools, :allow_destroy => true, :reject_if => lambda { |attributes| attributes['category'].blank? || attributes['description'].blank? }
  attr_accessible :report_id, :deterioration_id, :description, :tools_attributes,:user_id

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

