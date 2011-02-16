class CashPayInfosController < BaseController
  table :bill_no,: => :type
  include BillOperate
end
