#coding: utf-8
class CustomerCodeValidator < ActiveModel::EachValidator
  def validate_each(object,attribute,value)
    if value.present?
      object.errors[attribute] <<(options[:message] || "客户编号与姓名不匹配" ) unless Customer.exists?(:code => value,:name => object.from_customer_name,:is_active => true)
    end
  end
end
class CarryingBill < ActiveRecord::Base
  attr_protected :insured_rate,:original_carrying_fee,:original_goods_fee,:original_from_short_carrying_fee,:original_to_short_carrying_fee,:original_insured_amount,:original_insured_fee
  #营业额统计
  scope :turnover,select('from_org_id,to_org_id,sum(carrying_fee) as sum_carrying_fee,sum(goods_fee) as sum_goods_fee,sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count').group('from_org_id,to_org_id')

  #今日收货
  scope :today_billed,lambda {|from_org_ids| select('pay_type,sum(carrying_fee) as carrying_fee,sum(goods_fee) as goods_fee,sum(goods_num) goods_num,sum(1) as bill_count').where(:from_org_id => from_org_ids,:bill_date => Date.today).group(:pay_type)}
  #今日提货
  scope :today_deliveried,lambda {|to_org_ids| select('type,pay_type,sum(carrying_fee) as carrying_fee,sum(goods_fee)  as goods_fee,sum(goods_num) as goods_num,sum(1) as bill_count').where(:to_org_id => to_org_ids,:state =>:deliveried).search(:deliver_info_deliver_date_eq => Date.today).group('type,pay_type')}
  #今日提款(仅指现金提款)
  scope :today_paid,lambda {|from_org_ids| select('pay_type,sum(carrying_fee) as carrying_fee,sum(goods_fee) as goods_fee,sum(goods_num) as goods_num,sum(k_hand_fee) as k_hnad_fee,sum(1) as bill_count').where(:from_org_id => from_org_ids,:state =>:paid).search(:from_customer_id_is_null => 1,:pay_info_bill_date_eq => Date.today).group('pay_type')}
  #最近票据(5张)
  scope :recent_bills,lambda {|from_org_ids| where(:from_org_id => from_org_ids).order("created_at DESC").limit(12)}

  #待提货票据(不包括中转票据)
  scope :ready_delivery,lambda {|to_org_ids| select('sum(1) as bill_count').where(:to_org_id => to_org_ids,:state => :distributed)}
 #待提款票据 
  scope :ready_pay,lambda {|from_org_ids| search(:from_customer_id_is_null => 1).where(:from_org_id => from_org_ids,:state => :payment_listed).select('sum(goods_fee) as goods_fee,sum(1) as bill_count')}


  before_validation :set_customer
  #保存成功后,设置原始费用
  before_create :set_original_fee
  #计算手续费
  before_save :cal_hand_fee

  belongs_to :user
  belongs_to :from_org,:class_name => "Org" 
  belongs_to :transit_org,:class_name => "Org" 
  belongs_to :to_org,:class_name => "Org" 

  belongs_to :from_customer,:class_name => "Customer"

  #票据对应的装车清单
  belongs_to :load_list
  belongs_to :distribution_list

  belongs_to :deliver_info
  belongs_to :settlement
  belongs_to :refound
  belongs_to :payment_list
  belongs_to :pay_info
  belongs_to :post_info

  belongs_to :transit_info
  belongs_to :transit_deliver_info

  #于退货单来讲,所对应的原始票据,未退货的票据为空
  belongs_to :original_bill,:class_name => "CarryingBill"
  #对于原始单据来讲,有一个对应的退货单据
  has_one :return_bill,:foreign_key => "original_bill_id",:class_name => "ReturnBill"

  #短途运费核销信息
  belongs_to :short_fee_info

  #该运单对应的送货信息
  #当前活动的只能有一条
  has_one :send_list_line

  
  validates :bill_no,:goods_no,:uniqueness => true
  validates_presence_of :bill_date,:pay_type,:from_customer_name,:to_customer_name,:from_org_id
  validates_numericality_of :insured_amount,:insured_rate,:insured_fee,:carrying_fee,:goods_fee,:from_short_carrying_fee,:to_short_carrying_fee,:goods_num
  validates :customer_code,:customer_code => true
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
        :settlemented => :refunded,#返款
        :refunded => :refunded_confirmed,#返款确认
        :refunded_confirmed => :payment_listed,#支付清单
        :payment_listed => :paid,#货款已支付
        :paid => :posted #过帐结束

      #普通运单到货后有分发操作,中转运单不存在分发操作
      transition :reached => :distributed,:distributed => :deliveried,:if => lambda {|bill| bill.transit_org_id.blank?}

      #中转运单处理流程
      transition :reached => :transited,:transited => :deliveried,:if => lambda {|bill| bill.transit_org_id.present?}

      #TODO 现金付运费,不存在代收货款的运单,提货后处理流程如何?
    end


    #退货单处理流程
    #退货处理中,根据当前票据状态产生退货票据
    #after_transition :on => :return,[:reached,:distributed] => :returned,:do => :generate_return_bill
    event :return do
      #货物已发出,进行退货操作,会自动生成一张相反的单据
      transition [:reached,:distributed] => :returned
    end
    #运单重置处理
    after_transition :on => :reset,any => :billed,:do => :reset_bill
    event :reset do
      transition any => :billed
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

    #短途运费状态声明
    state_machine :short_fee_state,:initial => :draft do
      event :write_off  do
        transition :draft => :off
      end
      state :off do
        validates_presence_of :short_fee_info_id
      end
    end
    #字段默认值
    default_value_for :bill_date,Date.today
    default_value_for :goods_num,1
    default_value_for :insured_rate,0.003#IlConfig.insured_rate

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

    #付款方式描述
    def pay_type_des
      pay_type_des = ""
      CarryingBill.pay_types.each {|des,code| pay_type_des = des if code == self.pay_type }
      pay_type_des
    end

    def from_org_name
      ""
      self.from_org.name unless self.from_org.nil?
    end
    def transit_org_name
      ""
      self.transit_org.name unless self.transit_org.nil?
    end

    def to_org_name
      ""
      self.to_org.name unless self.to_org.nil?
    end
    #以千分数表示的保价费
    def insured_rate_disp
      self.insured_rate*1000
    end
    def insured_rate_disp=(rate)
    end
    #送货状态
    def send_state
      send_state = "draft"
      send_state = self.send_list_line.state if self.send_list_line.present?
      send_state
    end
    #提付运费,付款方式为提货付时,等于运费,其他为0
    def carrying_fee_th
      ret = 0
      ret = self.carrying_fee if self.pay_type == CarryingBill::PAY_TYPE_TH
      ret
    end
    #扣运费,运费支付方式为从货款扣除时等于运费,否则为0
    def k_carrying_fee
      ret = 0
      ret = self.carrying_fee if self.pay_type == CarryingBill::PAY_TYPE_K_GOODSFEE
      ret
    end
    #实提货款 原货款 - 扣运费 - 扣手续费
    def act_pay_fee
      ret = self.goods_fee - self.k_hand_fee - self.k_carrying_fee
    end
    #代收运费解释：原票运费支付方式为提货付的，代收运费=原运费—中转运费；
    #原票运费支付方式为现金付的，代收运费为0
    def agent_carrying_fee
      ret = 0
      ret = self.carrying_fee - self.transit_carrying_fee if pay_type == CarryingBill::PAY_TYPE_TH
      ret
    end

    #得到提货应收金额
    def th_amount
      amount = self.agent_carrying_fee - self.transit_hand_fee + self.goods_fee + self.to_short_carrying_fee 
      amount
    end
    #运费总计
    def carrying_fee_total
      carrying_fee + insured_fee + from_short_carrying_fee + to_short_carrying_fee
    end
    #代收货款支付方式,无客户编号时,为现金支付
    def goods_fee_cash?
      self.from_customer.blank?
    end
    #滞留天数
    def stranded_days
      (Date.today.end_of_day - self.bill_date.beginning_of_day) /1.day
    end

    #定义customer_code虚拟属性
    def customer_code
      @customer_code || self.from_customer.try(:code)
    end
    def customer_code=(customer_code)
      @customer_code = customer_code
    end
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
        :goods_no => nil,
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
        :carrying_fee => (pay_type == PAY_TYPE_CASH ? self.carrying_fee : 2*self.carrying_fee),
        :note => "原运单票据号:#{self.bill_no},货号:#{self.goods_no},运费:#{self.carrying_fee},代收货款;#{self.goods_fee}"
      }
      #如果是中转票据,则将中转站与始发站调换
      override_attr.merge!(:from_org_id => self.transit_org_id,:to_org_id => self.from_org_id) unless self.transit_org_id.blank?
      self.build_return_bill(self.attributes.merge(override_attr))
    end
    #重写to_s方法
    def to_s
      "#{self.bill_no}/#{self.goods_no}"
    end
    #导出方法
    def self.to_csv(search_obj,options = {},with_bom_header = true)
      options = self.export_options if options.blank?
      sum_info = self.search_sum(search_obj)
      #导出明细信息
      ret = search_obj.all.export_csv(options,with_bom_header)
      #导出合计信息
      sum_array =["合计"]
      #sum_array << "" if options[:methods].include?(:bill_date)
      sum_array << "" if options[:methods].include?(:bill_no)
      sum_array << "" if options[:methods].include?(:goods_no)
      sum_array << "" if options[:methods].include?(:from_customer_name)
      sum_array << "" if options[:methods].include?(:from_customer_phone)
      sum_array << "" if options[:methods].include?(:from_customer_mobile)
      sum_array << "" if options[:methods].include?(:to_customer_name)
      sum_array << "" if options[:methods].include?(:to_customer_phone)
      sum_array << "" if options[:methods].include?(:to_customer_mobile)
      sum_array << "" if options[:methods].include?(:from_org_name)
      sum_array << "" if options[:methods].include?(:transit_org_name)
      sum_array << "" if options[:methods].include?(:to_org_name)
      #用于显示合计票数
      sum_array << sum_info[:count] if options[:methods].include?(:pay_type_des)
      sum_array << sum_info[:sum_from_short_carrying_fee] if options[:methods].include?(:from_short_carrying_fee)
      sum_array << sum_info[:sum_to_short_carrying_fee] if options[:methods].include?(:to_short_carrying_fee)
      sum_array << sum_info[:sum_carrying_fee] if options[:methods].include?(:carrying_fee)
      sum_array << sum_info[:sum_carrying_fee_th] if options[:methods].include?(:carrying_fee_th)
      sum_array << sum_info[:sum_k_carrying_fee] if options[:methods].include?(:k_carrying_fee)
      sum_array << sum_info[:sum_k_hand_fee] if options[:methods].include?(:k_hand_fee)
      sum_array << sum_info[:sum_goods_fee] if options[:methods].include?(:goods_fee)
      sum_array << sum_info[:sum_insured_fee] if options[:methods].include?(:insured_fee)
      sum_array << sum_info[:sum_transit_carrying_fee] if options[:methods].include?(:transit_carrying_fee)
      sum_array << sum_info[:sum_transit_hand_fee] if options[:methods].include?(:transit_hand_fee)
      sum_array << sum_info[:sum_act_pay_fee] if options[:methods].include?(:act_pay_fee)
      sum_array << sum_info[:sum_agent_carrying_fee] if options[:methods].include?(:agent_carrying_fee)
      sum_array << sum_info[:sum_th_amount] if options[:methods].include?(:th_amount)
      sum_array << sum_info[:sum_goods_num] if options[:methods].include?(:goods_num)
      sum_array << "" if options[:methods].include?(:human_state_name)

      ret = ret + sum_array.export_line_csv
      ret
    end
    #得到票据合计信息
    def self.search_sum(search)
      sum_info = {
      :count => search.count,
      :sum_carrying_fee => search.relation.sum(:carrying_fee),
      #现金付运费合计
      :sum_carrying_fee_cash => search.where(:pay_type => CarryingBill::PAY_TYPE_CASH).sum(:carrying_fee),
      #提货付运费合计
      :sum_carrying_fee_th => search.where(:pay_type => CarryingBill::PAY_TYPE_TH).sum(:carrying_fee),
      #回执付运费合计
      :sum_carrying_fee_re => search.where(:pay_type => CarryingBill::PAY_TYPE_RETURN).sum(:carrying_fee),
      #自货款扣除运费合计
      :sum_k_carrying_fee => search.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:carrying_fee),
      #扣手续费合计
      :sum_k_hand_fee => search.relation.sum(:k_hand_fee),
      :sum_goods_fee => search.relation.sum(:goods_fee),
      :sum_insured_fee => search.relation.sum(:insured_fee),
      :sum_transit_carrying_fee => search.relation.sum(:transit_carrying_fee),
      :sum_transit_hand_fee => search.relation.sum(:transit_hand_fee),
      :sum_from_short_carrying_fee => search.relation.sum(:from_short_carrying_fee),
      :sum_to_short_carrying_fee => search.relation.sum(:to_short_carrying_fee),
      :sum_goods_num => search.relation.sum(:goods_num)
    }
    #实提货款合计
    sum_info[:sum_act_pay_fee] = sum_info[:sum_goods_fee] - sum_info[:sum_k_carrying_fee] - sum_info[:sum_k_hand_fee]
    sum_info[:sum_agent_carrying_fee] = sum_info[:sum_carrying_fee_th] - sum_info[:sum_transit_carrying_fee]
    sum_info[:sum_th_amount] = sum_info[:sum_agent_carrying_fee] - sum_info[:sum_transit_hand_fee] + sum_info[:sum_goods_fee]+ sum_info[:sum_to_short_carrying_fee]
    sum_info
  end


    protected
    #导出选项
    def self.export_options
      {
        :only => [],
        :methods => [
          :bill_date,:bill_no,:goods_no,:from_customer_name,:from_customer_phone,:from_customer_mobile,
          :to_customer_name,:to_customer_phone,:to_customer_mobile,:from_org_name,
          :transit_org_name,:to_org_name,:pay_type_des,:from_short_carrying_fee,:to_short_carrying_fee,
          :carrying_fee,:carrying_fee_th,:k_carrying_fee,:k_hand_fee,:goods_fee,:insured_fee,:transit_carrying_fee,
          :transit_hand_fee,:act_pay_fee,:agent_carrying_fee,:th_amount,:goods_num,:note,:human_state_name
      ]}
    end
    #生成票据编号
    def generate_bill_no
      #FIXME 票据号暂时设置为id
      self.bill_no = "%07d" % (CarryingBill.count > 0 ? CarryingBill.count : 1)
    end
    def generate_goods_no
      #货号规则
      #6位年月日+始发地市+到达地市+始发组织机构代码（如返程货则为到达地组织机构代码）+序列号+“-”+件数
      self.goods_no ="#{bill_date.strftime('%y%m%d')}#{from_org.simp_name}#{to_org.simp_name}#{today_sequence}-#{goods_num}" if self.to_org.present?
      self.goods_no ="#{bill_date.strftime('%y%m%d')}#{from_org.simp_name}#{transit_org.simp_name}#{today_sequence}-#{goods_num}" if self.transit_org.present?
    end
    private
    #获取当日发货单序列
    def today_sequence
      sequence = 1
      sequence = CarryingBill.where(:bill_date => Date.today,:from_org_id => from_org_id,:to_org_id => to_org_id).count + 1 if self.to_org_id.present?
      sequence = CarryingBill.where(:bill_date => Date.today,:from_org_id => from_org_id,:transit_org_id => transit_org_id).count + 1 if self.transit_org_id.present?
      sequence
    end
    #设置发货人关联信息
    def set_customer
      self.from_customer = nil if customer_code.blank?
      if Customer.exists?(:code => customer_code,:name => from_customer_name,:is_active => true)
        self.from_customer = Customer.where(:is_active => true).find_by_code(customer_code)
      end
    end
    #计算手续费
    def cal_hand_fee
      if self.goods_fee_cash?
        self.k_hand_fee = ConfigCash.cal_hand_fee(self.goods_fee)
      else
        self.k_hand_fee = self.from_customer.config_transit.rate * self.goods_fee
      end
      self.k_hand_fee
    end
    #保存票据成功后,设置原始费用
    def set_original_fee
      self.original_carrying_fee = self.carrying_fee
      self.original_from_short_carrying_fee = self.from_short_carrying_fee
      self.original_to_short_carrying_fee = self.to_short_carrying_fee
      self.original_goods_fee = self.goods_fee
      self.original_insured_amount = self.insured_amount
      self.original_insured_fee = self.insured_fee
    end
    #重置票据
    def reset_bill
      self.update_attributes(:load_list_id => nil,:distribution_list_id => nil,:deliver_info_id => nil,:settlement_id => nil,:refound_id => nil,:payment_list_id => nil,:pay_info_id => nil,:post_info_id => nil,:transit_info_id => nil)
    end
  end
