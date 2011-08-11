class Observation < ActiveRecord::Base
  has_paper_trail :only => [:category, :body]
  belongs_to :user
  belongs_to :report
  attr_accessible :report_id, :category, :body, :user_id
  CATEGORIES = [['informacion','informacion'],['diagnostico','diagnostico'],['otro','otro']]
  validates_presence_of :category, :body
end

