#coding: utf-8
class TransitDeliverInfo < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  has_one :carrying_bill
  validates_presence_of :org_id
  default_scope :include => :carrying_bill
  #定义状态机
  state_machine :initial => :billed do
    after_transition do |deliver,transition|
      deliver.carrying_bill.transit_hand_fee = deliver.transit_hand_fee
      deliver.carrying_bill.standard_process
    end
    event :process do
      transition :billed =>:deliveried
    end
  end

  default_value_for :bill_date,Date.today
end
