class TransferPayInfosController < BaseController
  table :except => :type
  include BillOperate
end
