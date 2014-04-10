class Job < ActiveRecord::Base
  #TODO validates_presence
  belongs_to :organization
  attr_accessible :description, :title
end
