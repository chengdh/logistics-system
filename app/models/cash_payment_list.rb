#coding: utf-8
class CashPaymentList < PaymentList
  attr_protected :bank_id
  validates :org_id,:presence => true
end
