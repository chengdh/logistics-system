#coding: utf-8
class SendListPost < ActiveRecord::Base
  include SendListModule
  belongs_to :user
  belongs_to :org
  belongs_to :sender
  has_many :send_list_lines
  default_value_for :bill_date,Date.today
  validates_presence_of :sender_id,:org_id
end
