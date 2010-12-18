class PaymentList < ActiveRecord::Base
  belongs_to :bank
  belongs_to :org
  has_many :carrying_bills
  #TODO belongs_to :user
  default_value_for :bill_date,Date.today
end
