#coding: utf-8
class CarryingBill < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org" 
  belongs_to :to_org,:class_name => "Org" 
  validates :bill_no,:goods_no,:uniqueness => true
  validates_presence_of :bill_date,:pay_type,:from_customer_name,:to_customer_name,:from_org_id,:to_org_id
  validates_numericality_of :insured_amount,:insured_rate,:insured_fee,:carrying_fee,:goods_fee,:from_short_carrying_fee,:to_short_carrying_fee,:goods_num
  #定义state_machine


  default_value_for :bill_date,Date.today
  default_value_for :goods_num,1

  PAY_TYPE_CASH = "CA"    #现金付
  PAY_TYPE_TH = "TH"      #提货付
  PAY_TYPE_RETURN = "RE"  #回执付
  PAY_TYPE_K_GOODSFEE = "KG"  #自货款扣除
  #付款方式描述
  def self.pay_types
    {
      "现金付" => PAY_TYPE_CASH ,
      "提货付" => PAY_TYPE_TH,
      "回执付" => PAY_TYPE_RETURN,
      "自货款扣除" => PAY_TYPE_K_GOODSFEE 
    }
  end
  def from_org_name
    ""
    self.from_org.name unless self.from_org.nil?
  end
  def to_org_name
    ""
    self.to_org.name unless self.to_org.nil?
  end
end
