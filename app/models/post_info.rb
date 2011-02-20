#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
class PostInfo < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  has_many :carrying_bills
  validates_presence_of :org_id

  #定义状态机
  state_machine :initial => :billed do
    after_transition do |pi,transition|
      pi.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:posted
    end
  end

  default_value_for :bill_date,Date.today
  #以下定义虚拟属性
  #从货款扣运费合计
  def sum_k_carrying_fee
    self.carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:carrying_fee)
  end
  #原运费合计
  def sum_goods_fee 
    self.carrying_bills.sum(:goods_fee)
  end
  #扣手续费合计
  def sum_k_hand_fee
    self.carrying_bills.sum(:k_hand_fee)
  end
  #实际支付运费
  def sum_act_pay_fee
    sum_goods_fee - sum_k_carrying_fee - sum_k_hand_fee
  end
  #余额
  def sum_rest_fee
    amount_fee - sum_pay_fee
  end
  #导出到csv
  def to_csv
    ret = ["结算员:",self.user.try(:username),"结算单位:",self.org.name,"结算日期:",self.bill_date].export_line_csv(true)
    ret +=["","","","","实领金额",self.amount_fee].export_line_csv
    ret +=["原货款",self.sum_goods_fee,"扣运费",self.sum_k_carrying_fee,"扣手续费",self.sum_k_hand_fee,"实际提款",self.sum_act_pay_fee].export_line_csv
    ret +=["","","","","余额",self.sum_rest_fee].export_line_csv
    csv_carrying_bills = CarryingBill.to_csv(self.carrying_bills.search,PostInfo.carrying_bill_export_options,false)
    ret + csv_carrying_bills
  end
  private
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
