class SendListBack < ActiveRecord::Base
  belongs_to :org
  belongs_to :sender
  belongs_to :user
  has_many :send_list_lines
  default_value_for :bill_date,Date.today
end
