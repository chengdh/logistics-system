class GoodsExceptionIdentify < ActiveRecord::Base
  belongs_to :goods_exception
  belongs_to :user
  default_value_for :bill_date,Date.today
end
