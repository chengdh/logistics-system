class PaymentList < ActiveRecord::Base
  belongs_to :bank
  belongs_to :org
  has_many :carrying_bills
  belongs_to :user
  #定义状态机
  state_machine :initial => :billed do
    after_transition do |payment_list,transition|
      payment_list.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:payment_listed
    end
  end

  default_value_for :bill_date,Date.today
end
