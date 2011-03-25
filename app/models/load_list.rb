#coding: utf-8
class LoadList < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  belongs_to :user
  has_many :carrying_bills

  validates_presence_of :from_org_id,:to_org_id,:bill_no
  #待确认收货清单
  scope :shipped,lambda {|to_org_ids| select("sum(1) as bill_count").where(:state => :shipped,:to_org_id => to_org_ids)}
  #定义状态机
  state_machine :initial => :billed do
    after_transition do |load_list,transition|
      load_list.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:loaded,:loaded => :shipped,:shipped => :reached
    end
  end

  #FIXME 缺省值设定应定义到state_machine之后
  default_value_for :bill_date,Date.today

  def from_org_name
    ""
    self.from_org.name unless self.from_org.nil?
  end
  def to_org_name
    ""
    self.to_org.name unless self.to_org.nil?
  end
  #导出到csv
  def to_csv
    ret = ["清单日期:",self.bill_date,"清单编号:",self.bill_no,"发货站:",self.from_org_name,"到达站:",self.to_org_name,"状态:" , self.human_state_name].export_line_csv(true)
    csv_carrying_bills = CarryingBill.to_csv(self.carrying_bills.search,LoadList.carrying_bill_export_options,false)
    ret + csv_carrying_bills
  end
  private
  def self.carrying_bill_export_options
    {
        :only => [],
        :methods => [
          :bill_date,:bill_no,:goods_no,:from_customer_name,:from_customer_phone,:from_customer_mobile,
          :to_customer_name,:to_customer_phone,:to_customer_mobile,
          :pay_type_des,
          :carrying_fee,:goods_fee,
          :note,:human_state_name
      ]}
  end
end
