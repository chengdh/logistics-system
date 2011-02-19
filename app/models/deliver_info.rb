#coding: utf-8
class DeliverInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :org
  has_many :carrying_bills
  validates_presence_of :customer_name,:deliver_date,:org_id
  #定义状态机
  state_machine :initial => :billed do
    after_transition do |deliver_info,transition|
      deliver_info.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:deliveried
    end
  end
  default_value_for :deliver_date,Date.today
  #合计应收运费
  def sum_carrying_fee
    self.carrying_bills.to_a.sum(&:carrying_fee_th)
  end
  #合计应收代收货款
  def sum_goods_fee
    self.carrying_bills.to_a.sum(&:goods_fee)
  end
  #合计提货应收费用
  def sum_th_fee
    self.carrying_bills.to_a.sum(&:th_amount)
  end
  #运单编号
  def bill_no
    self.carrying_bills.collect {|bill| "#{bill.bill_no}/#{bill.goods_no}"}.join(",")
  end
  #导出
  def self.to_csv(search_obj)
      search_obj.all.export_csv(self.export_options)
  end
  private
  def self.export_options
    {
      :only => [],
      :methods => [:org,:deliver_date,:bill_no,:customer_name,:customer_no,:sum_carrying_fee,:sum_goods_fee,:sum_th_fee]
    }
  end
end
