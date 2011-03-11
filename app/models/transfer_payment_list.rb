#coding: utf-8
#FIXME 此处有问题,转账时,不受权限限制,如何处理？
class TransferPaymentList < PaymentList
  validates_presence_of :bank_id
  #导出为建行转账格式文本
  def ccb_to_txt
    ret = ''
    self.carrying_bills.each_with_index do |bill,index|
      ret += [index + 1,1,bill.from_customer.bank_card,bill.from_customer.name,'建行',bill.act_pay_fee,'货款',0].join('|') + "|\r\n"
    end
    ret
  end
  def self.carrying_bill_export_options
    {
        :only => [],
        :methods => [
          :bill_no,:act_pay_fee,:from_customer_bank_card,:from_customer_name,:from_customer_code,:from_customer_bank_name,:goods_fee,:k_hand_fee,:k_carrying_fee,:goods_no
      ]}
  end

end
