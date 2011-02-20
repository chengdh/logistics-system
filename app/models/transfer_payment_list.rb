#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
class TransferPaymentList < PaymentList
  attr_protected :org_id
  validates_presence_of :bank_id
end
