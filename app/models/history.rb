class History < ActiveRecord::Base
  has_many :history_changes
  belongs_to :historyable, :polymorphic => true
end

