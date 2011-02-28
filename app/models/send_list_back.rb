#coding: utf-8
class SendListBack < ActiveRecord::Base
  include SendListModule
  belongs_to :org
  belongs_to :sender
  belongs_to :user
  has_many :send_list_lines
  default_value_for :bill_date,Date.today
  validates_presence_of :org_id,:sender_id
end
