#coding: utf-8
#中转机打运单
class TransitBill < CarryingBill
  before_create :generate_bill_no,:generate_goods_no
  validates_presence_of :transit_org_id
end
