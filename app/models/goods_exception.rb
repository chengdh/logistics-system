#coding: utf-8
class GoodsException < ActiveRecord::Base
  belongs_to :carrying_bill
  belongs_to :user
  belongs_to :org
  #授权核销信息
  has_one :gexception_authorize_info
  #理赔信息
  has_one :claim
  #责任鉴定信息
  has_one :goods_exception_identify
  accepts_nested_attributes_for :gexception_authorize_info,:claim,:goods_exception_identify

  validates_presence_of :org_id
  #定义状态机
  state_machine :initial => :submited do
    event :process do
      #已上报 -- 已授权核销 --- 已赔偿 -- 责任已鉴定
      transition :submited =>:authorized,:authorized => :compensated,:compensated => :identified
    end
  end

  #FIXME 缺省值设定应定义到state_machine之后
  default_value_for :bill_date,Date.today

  EXCEPT_LACK= "LA"           #少货
  EXCEPT_SHORTAGE = "SH"      #短缺
  EXCEPT_DAMAGED = "DA"       #破损
  #付款方式描述
  def self.exception_types
    {
      "少货" => EXCEPT_LACK,          #少货
      "短缺" => EXCEPT_SHORTAGE,      #短缺
      "破损" => EXCEPT_DAMAGED        #破损
    }
  end
end
