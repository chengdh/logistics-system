class ShortFeeInfo < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  has_many :carrying_bills
  validates_presence_of :org_id,:bill_date
  #定义状态机
  state_machine :initial => :draft do
    after_transition do |info,transition|
      info.carrying_bills.each {|bill| bill.write_off }
    end
    event :write_off do
      transition :draft =>:offed
    end
  end

  #FIXME 缺省值设定应定义到state_machine之后
  default_value_for :bill_date,Date.today
end
