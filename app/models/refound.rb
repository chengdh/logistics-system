class Refound < ActiveRecord::Base
  #TODO belongs_to :user
  has_many :carrying_bills
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  validates_presence_of :bill_date,:from_org_id,:to_org_id
  #定义状态机
  state_machine :initial => :billed do
    after_transition do |refound,transition|
      refound.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:refunded,:refunded => :refunded_confirmed
    end
  end

  default_value_for :bill_date,Date.today

  def sum_fee
    self.sum_goods_fee + self.sum_carrying_fee
  end
end
