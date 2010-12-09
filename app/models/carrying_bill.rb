#coding: utf-8
class CarryingBill < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org" 
  belongs_to :transit_org,:class_name => "Org" 
  belongs_to :to_org,:class_name => "Org" 
  belongs_to :deliver_info

  #于退货单来讲,所对应的原始票据,未退货的票据为空
  belongs_to :original_bill,:class_name => "CarryingBill"
  #对于原始单据来讲,有一个对应的退货单据
  has_one :return_bill,:foreign_key => "original_bill_id",:class_name => "ReturnBill"

  #票据对应的装车清单
  belongs_to :load_list
  belongs_to :distribution_list

  validates :bill_no,:goods_no,:uniqueness => true
  validates_presence_of :bill_date,:pay_type,:from_customer_name,:to_customer_name,:from_org_id,:to_org_id
  validates_numericality_of :insured_amount,:insured_rate,:insured_fee,:carrying_fee,:goods_fee,:from_short_carrying_fee,:to_short_carrying_fee,:goods_num
  #定义state_machine
  #已开票
  #已装车
  #已发出
  #已到货
  #已分发(分货处理)
  #已中转(针对中转票据)
  #已提货
  #已日结(结算员已交款)
  #已返款
  #已到帐
  #已提款
  #已退货
  state_machine :initial => :billed do
    #正常运单处理流程(包括机打运单/手工运单/退货单据)
    event :standard_process do
      transition :billed => :loaded,   #装车
        :loaded => :shipped,#发货
        :shipped => :reached,#到货
        :deliveried => :settlemented,#日结清单
        :settlemented => :rebated,#返款
        :rebated => :rebate_confirmed,#返款确认
        :rebate_confirmed => :payment_listed,#支付清单
        :payment_listed => :paid#货款已支付

      #普通运单到货后有分发操作,中转运单不存在分发操作
      transition :reached => :distributed,:distributed => :deliveried,:if => lambda {|bill| bill.transit_org.blank?}

      #中转运单处理流程
      transition :reached => :transited,:transited => :deliveried,:if => lambda {|bill| !bill.transit_org.blank?}
    end


    #退货单处理流程
    #退货处理中,根据当前票据状态产生退货票据
    after_transition :on => :return,[:shipped,:reached,:distributed] => :returned,:do => :generate_return_bill
    event :return do
      #未发出已退货
      transition [:billed,:loaded] => :returned
      #货物已发出,进行退货操作,会自动生成一张相反的单据
      transition [:shipped,:reached,:distributed] => :returned
    end
    #根据运单状态进行验证操作
    state :loaded,:shipped,:reached do
      validates_presence_of :load_list_id
    end
    state :distributed do
      validates_presence_of :distribution_list_id
    end
    #TODO 添加其他处理时的验证处理


    end
    #字段默认值
    default_value_for :bill_date,Date.today
    default_value_for :goods_num,1

    PAY_TYPE_CASH = "CA"    #现金付
    PAY_TYPE_TH = "TH"      #提货付
    PAY_TYPE_RETURN = "RE"  #回执付
    PAY_TYPE_K_GOODSFEE = "KG"  #自货款扣除
    #付款方式描述
    def self.pay_types
      {
        "现金付" => PAY_TYPE_CASH ,
        "提货付" => PAY_TYPE_TH,
        "回执付" => PAY_TYPE_RETURN,
        "自货款扣除" => PAY_TYPE_K_GOODSFEE 
      }
    end
    def from_org_name
      ""
      self.from_org.name unless self.from_org.nil?
    end
    def to_org_name
      ""
      self.to_org.name unless self.to_org.nil?
    end
    #得到提货应收金额
    def th_amount
      amount = carrying_fee
      amount += goods_fee if pay_type == CarryingBill::PAY_TYPE_TH
      amount += to_short_carrying_fee
      amount
    end
    #运费总计
    def carrying_fee_total
      carrying_fee + insured_fee + from_short_carrying_fee + to_short_carrying_fee
    end

    protected
    #生成退货单据
    #录入原运单编号后回车，可显示原票信息退货信息：
    #退货运单编号为TH原运单编号，
    #货号在确认时由电脑按始发货规则自动编，
    #结算单位、组织机构默认为当前操作员所属，
    #发货站、到达站、发货人、收货人、电话、手机为原票信息颠倒，
    #运费支付方式默认提货付，
    #代收货款默认为0，代收货款支付方式默认为现金支付，
    #货物信息、保价内容按原票显示，
    #运费如原票支付方式为现金付的则自动显示为单倍，其他支付方式的显示为双倍运费，
    #备注自动显示原票代收货款及货号。
    #如中转货退回，则中转站还显示原中转站。
    #确认后，原票状态应显示为已退且在未提货中取消，在本地发货时增加该票
    def generate_return_bill
      #TODO 设置票据操作人员信息
      override_attr = {
        :bill_no => "TH#{self.bill_no}",
        :bill_date => Date.today,
        :from_org_id => self.to_org_id,
        :to_org_id => self.from_org_id,
        :from_customer_name => self.to_customer_name,
        :from_customer_phone => self.to_customer_phone,
        :to_customer_name => self.from_customer_name,
        :to_customer_phone => self.from_customer_phone,
        :from_customer_id => nil,
        :to_customer_id => nil,
        :pay_type => PAY_TYPE_TH,
        :goods_fee => 0,
        :carrying_fee => (pay_type == PAY_TYPE_CASH ? self.carrying_fee : 2*self.carrying_fee)
      }
      #如果是中转票据,则将中转站与始发站调换
      override_attr.merge!(:from_org_id => self.transit_org_id,:to_org_id => self.from_org_id) unless self.transit_org_id.blank?
      self.create_return_bill(self.attributes.merge(override_attr))
    end
    #生成票据编号
    def generate_bill_no
      #FIXME 票据号暂时设置为id
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
      CarryingBill.where(:bill_date => Date.today,:from_org_id => from_org_id,:to_org_id => to_org_id).count + 1
    end
  end
