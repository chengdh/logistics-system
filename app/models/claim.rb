class Claim < ActiveRecord::Base
  belongs_to :user
  belongs_to :goods_exception
  belongs_to :user
  default_value_for :bill_date,Date.today

  #TODO 理赔金额不应大于拟赔金额
end
