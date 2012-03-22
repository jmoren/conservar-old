class SpecialTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :collection
  attr_accessible :collection_id, :user_id, :description, :date

  scope :by_collection, lambda{|col| where(:collection_id => col )}
  scope :by_user, lambda{|user| where(:user_id => user )}
end

