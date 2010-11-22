class LoadList < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"

  default_value_for :bill_date,Date.today

  validates_presence_of :from_org_id,:to_org_id
end
