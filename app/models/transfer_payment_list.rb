class TransferPaymentList < PaymentList
  attr_protected :org_id
  validates_presence_of :bank_id
end
