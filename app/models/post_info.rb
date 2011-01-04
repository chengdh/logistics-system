class PostInfo < ActiveRecord::Base
  belongs_to :org
  #TODO 暂时注释
  #belongs_to :user
  has_many :carrying_bills
  validates_presence_of :org_id

  #定义状态机
  state_machine :initial => :billed do
    after_transition do |pi,transition|
      pi.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:posted
    end
  end

  default_value_for :bill_date,Date.today
  #以下定义虚拟属性
  #从货款扣运费合计
  def sum_k_carrying_fee
    self.carrying_bills.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:carrying_fee)
  end
  #原运费合计
  def sum_goods_fee 
    self.carrying_bills.sum(:goods_fee)
  end
  #扣手续费合计
  def sum_k_hand_fee
    self.carrying_bills.sum(:k_hand_fee)
  end
  #实际支付运费
  def sum_pay_fee
    sum_goods_fee - sum_k_carrying_fee - sum_k_hand_fee
  end
  #余额
  def sum_rest_fee
    amount_fee - sum_pay_fee
  end
end
