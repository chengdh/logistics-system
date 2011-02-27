#coding: utf-8
#汇款记录
class Remittance < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  belongs_to :user
  belongs_to :refound
  validates_presence_of :from_org_id,:to_org_id,:refound_id
  validates_numericality_of :should_fee,:act_fee
  #定义状态机
  #草稿 -- 已汇款
  state_machine :initial => :draft do
    event :process do
      transition :draft =>:complete
    end
  end

  default_value_for :bill_date,Date.today

  #剩余未汇金额
  def rest_fee
    self.should_fee - self.act_fee
  end
end
