class Tool < ActiveRecord::Base
  has_paper_trail
  belongs_to :task
end

