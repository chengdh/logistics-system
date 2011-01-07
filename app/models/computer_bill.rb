#coding: utf-8
#机打票
class ComputerBill < CarryingBill
  #创建数据前声称票据编号和货号
  before_create :generate_bill_no,:generate_goods_no
  validates_presence_of :to_org_id
end
