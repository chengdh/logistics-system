#coding: utf-8
#FIXME 此处有问题,转账时,不受权限限制,如何处理？
class TransferPaymentList < PaymentList
  validates_presence_of :bank_id
end
