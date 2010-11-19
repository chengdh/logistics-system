#coding: utf-8
#退货单
class ReturnBill < CarryingBill
  before_create :generate_goods_no
end
