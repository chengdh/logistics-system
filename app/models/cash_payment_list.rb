#coding: utf-8
class CashPaymentList < PaymentList
  attr_protected :bank_id
  validates :org_id,:presence => true
  #定义状态机
  state_machine :initial => :billed do
    after_transition do |payment_list,transition|
      payment_list.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:payment_listed
    end
  end

end
