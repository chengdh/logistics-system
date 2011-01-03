class PayInfo < ActiveRecord::Base
  has_many :carrying_bills
  belongs_to :org
  #belongs_to :user
  #定义状态机
  state_machine :initial => :billed do
    after_transition do |pay_info,transition|
      pay_info.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:paid
    end
  end

  default_value_for :bill_date,Date.today
end
