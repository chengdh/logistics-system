#coding: utf-8
class PaymentList < ActiveRecord::Base
  belongs_to :bank
  belongs_to :org
  has_many :carrying_bills
  belongs_to :user
 
  default_value_for :bill_date,Date.today
  #导出到csv
  def to_csv
    ret_array = ["分理处/分公司:",self.org.name,"清单日期:",self.bill_date,"结算员:",self.user.try(:username)]
    #如果是转账清单,则需要显示银行
    #ret_array = ret_array + ["银行:",self.bank.try(:name)] if self.type == "TransferPaymentList"
    ret = ret_array.export_line_csv(true)
    ret = ret + ["备注:",self.note].export_line_csv
    csv_carrying_bills = CarryingBill.to_csv(self.carrying_bills.search,self.class.carrying_bill_export_options,false)
    ret + csv_carrying_bills
  end
  def self.carrying_bill_export_options
    {
        :only => [],
        :methods => [
          :bill_date,:bill_no,:goods_no,:from_customer_name,:from_customer_phone,:from_customer_mobile,
          :pay_type_des,
          :k_carrying_fee,:k_hand_fee,:goods_fee,:act_pay_fee,
          :note,:human_state_name
      ]}
  end
end
