#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
class SendList < ActiveRecord::Base
  include SendListModule
  belongs_to :sender
  belongs_to :org
  belongs_to :user
  has_many :send_list_lines
  default_value_for :bill_date,Date.today
end
