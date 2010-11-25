class LoadList < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  has_many :carrying_bills


  validates_presence_of :from_org_id,:to_org_id
  #定义状态机
  state_machine :initial => :loaded do
    after_transition do |load_list,transition|
      load_list.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :loaded => :shipped,:shipped => :reached
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

end
