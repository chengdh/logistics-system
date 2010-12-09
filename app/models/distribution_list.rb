class DistributionList < ActiveRecord::Base
  #TODO belongs_to :user
  has_many :carrying_bills
  belongs_to :org
  validates_presence_of :org_id,:bill_date
  #定义状态机
  state_machine :initial => :billed do
    after_transition do |distribution_list,transition|
      distribution_list.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:distributed
    end
  end


  default_value_for :bill_date,Date.today
end
