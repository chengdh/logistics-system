class SendListPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :org
  belongs_to :sender
  has_many :send_list_lines
  default_value_for :bill_date,Date.today
end
