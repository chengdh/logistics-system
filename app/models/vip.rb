#coding: utf-8
#贵宾客户
class Vip <  Customer
  belongs_to :bank
  belongs_to :org
  attr_protected :code
  validates :id_number,:org_id,:bank_id,:bank_card,:presence => true
  validates :code,:uniqueness => true
  validates :bank_card,:length => {:maximum => 19}

  validates_presence_of :config_transit_id

  after_validation :set_code
  private
  def set_code
    self.code = self.bank.code + self.org.code + get_sequence
  end
  #根据机构获取当前机构已有的VIP客户数量
  def get_sequence
    se = "%04d" % (Vip.where(:org_id => self.org_id).count + 1)
  end
#导出
  def self.to_csv(search_obj)
    search_obj.all.export_csv(self.export_options)
  end
  private
  def self.export_options
    {
      :only => [],
      :methods => [:org,:name,:code,:phone,:mobile,:address,:bank,:bank_card]
    }
  end
end
