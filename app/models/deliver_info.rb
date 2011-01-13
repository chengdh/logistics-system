class DeliverInfo < ActiveRecord::Base
  #TODO belongs_to :user
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
end
