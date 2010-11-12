#coding: utf-8
class CarryingBill < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org" 
  belongs_to :to_org,:class_name => "Org" 
  validates :bill_no,:goods_no,:uniqueness => true
  validates_presence_of :bill_date,:pay_type,:from_customer_name,:to_customer_name,:from_org_id,:to_org_id


  default_value_for :bill_date,Date.today

  PAY_TYPE_CASH = "CA"    #现金付
  PAY_TYPE_TH = "TH"      #提货付
  PAY_TYPE_RETURN = "RE"  #回执付
  PAY_TYPE_K_GOODSFEE = "KG"  #自货款扣除
  #付款方式描述
  def self.pay_types
    {
      PAY_TYPE_CASH => "现金付",
      PAY_TYPE_TH => "提货付",
      PAY_TYPE_RETURN => "回执付",
      PAY_TYPE_K_GOODSFEE => "自货款扣除"
    }
  end
end
