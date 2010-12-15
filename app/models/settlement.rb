class Settlement < ActiveRecord::Base
  #TODO belongs_to :user
  has_many :carrying_bills
  belongs_to :org
  validates_presence_of :org_id
  #定义状态机
  state_machine :initial => :billed do
    after_transition do |settlement,transition|
      settlement.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:settlemented
    end
  end
  def sum_fee
    self.sum_carrying_fee + self.sum_goods_fee
  end
end
