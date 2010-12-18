class PayInfo < ActiveRecord::Base
  has_many :carrying_bills
  belongs_to :org
  #belongs_to :user

  default_value_for :bill_date,Date.today
end
