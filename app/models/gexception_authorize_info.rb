class GexceptionAuthorizeInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :goods_exception

  default_value_for :bill_date,Date.today
end
