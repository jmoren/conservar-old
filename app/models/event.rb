class Event < ActiveRecord::Base
  has_paper_trail :only => [:title, :activity, :start_at, :end_at,:report_id]
  belongs_to :user
  attr_accessible :user_id, :title, :activity, :start_at, :end_at, :all_day, :report_id

  def update_dates(new_date)
    self.update_attributes(:end_at => new_date, :start_at => new_date)
  end
end

