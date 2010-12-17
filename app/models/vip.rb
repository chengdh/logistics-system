#coding: utf-8
#贵宾客户
class Vip <  Customer
  belongs_to :bank
  belongs_to :org
  attr_protected :code
  validates :code,:id_number,:org_id,:bank_id,:bank_card,:presence => true
  validates :code,:uniqueness => true
  validates :bank_card,:length => {:maximum => 19}
  before_validation :set_code
  private
  def set_code
    self.code = self.bank.code + self.org.code + get_sequence
  end
  #根据机构获取当前机构已有的VIP客户数量
  def get_sequence
    se = "%04d" % (Vip.where(:org_id => self.org_id).count + 1)
  end
end
