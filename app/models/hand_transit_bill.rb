#coding: utf-8
#手工中转运单
class HandTransitBill < CarryingBill
  validates_presence_of :transit_org_id
end
