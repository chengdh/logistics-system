#coding: utf-8
#客户费用合计
class CustomerFeeInfo < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  has_many :customer_fee_info_lines,:dependent => :delete_all
  validates_presence_of :org_id,:mth

  #从运单中生成数据
  #默认导入上月数据
  #按照 姓名 + 电话 认定为同一人
  def self.generate_data(org_id)
    mth = 1.months.ago.strftime("%Y%m")
    cfi = self.find_or_create_by_mth_and_org_id(mth,org_id)
    cfi.customer_fee_info_lines.clear
    #得到给定时间段的客户数据(从运单表中提取)
    f_date = 1.months.ago.beginning_of_month
    #FIXME 此处应修改
    t_date = 1.months.since.end_of_month
    CarryingBill.search(:from_org_id_eq => org_id,:bill_date_gte => f_date,:bill_date_lte => t_date ).select('from_customer_name,from_customer_phone,sum(carrying_fee) sum_carrying_fee').group('from_customer_name,from_customer_phone').each do |bill|
      cfi.customer_fee_info_lines.create(:name =>bill.from_customer_name,:phone => bill.from_customer_phone,:fee => bill.sum_carrying_fee)
    end
    #返程货统计
    CarryingBill.search(:to_org_id_eq => org_id,:bill_date_gte => f_date,:bill_date_lte => t_date).select('to_customer_name,to_customer_phone,sum(carrying_fee) sum_carrying_fee').group('to_customer_name,to_customer_phone').each do |bill|
      the_line = cfi.customer_fee_info_lines.find_or_create_by_name_and_phone(bill.to_customer_name,bill.to_customer_phone)
      the_line.update_attributes(:fee => bill.sum_carrying_fee + the_line.fee)
    end
    ImportedCustomer.update_state!(org_id)
  end
end
