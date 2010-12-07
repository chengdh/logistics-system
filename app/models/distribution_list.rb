class DistributionList < ActiveRecord::Base
  #TODO belongs_to :user
  has_many :carrying_bills
end
