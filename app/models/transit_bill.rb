#coding: utf-8
#中转机打运单
class TransitBill < CarryingBill
  before_save :generate_goods_no
  before_create :generate_bill_no
  validates_presence_of :transit_org_id
end
