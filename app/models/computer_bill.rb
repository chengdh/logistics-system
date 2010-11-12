#coding: utf-8
#机打票
class ComputerBill < CarryingBill
  #创建数据前声称票据编号和货号
  before_create :generate_bill_no
  before_create :generate_goods_no

  #validates_presence_of :from_customer_name,:message => '发货人姓名不可为空'

  private
  def generate_bill_no
    #TODO 票据号暂时设置为id
    self.bill_no = "%07d" % (CarryingBill.count > 0 ? CarryingBill.count : 1)
  end
  def generate_goods_no
    #货号规则
    #6位年月日+始发地市+到达地市+始发组织机构代码（如返程货则为到达地组织机构代码）+序列号+“-”+件数
    self.goods_no ="#{bill_date.strftime('%y%m%d')}#{from_org.simp_name}#{to_org.simp_name}#{today_sequence}-#{goods_num}"
  end
  private
  #获取当日发货单序列
  def today_sequence
    ComputerBill.where(:bill_date => Date.today,:from_org_id => from_org.id,:to_org_id => to_org.id).joins(:from_org,:to_org).count + 1
  end
end
