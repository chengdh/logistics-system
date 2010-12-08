class DistributionList < ActiveRecord::Base
  #TODO belongs_to :user
  has_many :carrying_bills
  default_value_for :bill_date,Date.today
end
