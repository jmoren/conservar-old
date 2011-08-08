class Event < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :title, :activity, :start_at, :end_at, :all_day, :report_id

end

