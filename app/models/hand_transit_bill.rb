#coding: utf-8
#手工中转运单
class HandTransitBill < CarryingBill
  validates_presence_of :transit_org_id
  #手工运单,编号从0 ～ 3999999
  validates_inclusion_of :bill_no,:in => '0000000'..'3999999'
  #验证货号格式
  validates_format_of :goods_no, 
          :with =>/(\d{6})?((?:\xe4[\xb8-\xbf][\x80-\xbf]|[\xe5-\xe8][\x80-\xbf][\x80-\xbf]|\xe9[\x80-\xbd][\x80-\xbf]|\xe9\xbe[\x80-\xa5])*)?(\d{1,10})-(\d{1,10})/
          #默认货号
  default_value_for :goods_no,Date.today.strftime('%y%m%d')

end
