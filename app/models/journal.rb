class Journal < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  default_value_for :bill_date,Date.today
  #带org的构造函数
  def self.new_with_org(org,bill_date=Date.today)
    journal = Journal.new(:org => org,:bill_date => bill_date)
    #已结算未汇金额
    journal.settled_no_rebate_fee = 
      CarryingBill.search(:state_eq => 'settlemented',:to_org_id_or_transit_org_id_eq => org.id,:pay_type_eq =>'TH' ).relation.sum(:carrying_fee) 
    + CarryingBill.search(:state_eq => 'settlemented',:to_org_id_or_transit_org_id_eq => org.id).relation.sum(:goods_fee)
    + CarryingBill.search(:state_eq => 'settlemented',:to_org_id_or_transit_org_id_eq => org.id).relation.sum(:to_short_carrying_fee)
    #已提货未结算金额
    journal.deliveried_no_settled_fee = 
      CarryingBill.search(:state_eq => 'deliveried',:to_org_id_or_transit_org_id_eq => org.id,:pay_type_eq =>'TH' ).relation.sum(:carrying_fee) 
    + CarryingBill.search(:state_eq => 'deliveried',:to_org_id_or_transit_org_id_eq => org.id).relation.sum(:goods_fee)
    + CarryingBill.search(:state_eq => 'deliveried',:to_org_id_or_transit_org_id_eq => org.id).relation.sum(:to_short_carrying_fee)
    #黑/红/黄/绿/蓝/白
    journal.black_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_lte => 21.days.ago.end_of_day).count
    journal.red_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_lte => 17.days.ago.end_of_day,:bill_date_gte => 20.days.ago.end_of_day).count
    journal.yellow_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_lte => 13.days.ago.end_of_day,:bill_date_gte => 16.days.ago.end_of_day).count
    journal.green_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_lte => 9.days.ago.end_of_day,:bill_date_gte => 12.days.ago.end_of_day).count
    journal.blue_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_lte => 5.days.ago.end_of_day,:bill_date_gte => 8.days.ago.end_of_day).count
    journal.white_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_gte => 4.days.ago.end_of_day).count
    journal
  end
  #计算合计
  def sum_1
    self.settled_no_rebate_fee + self.deliveried_no_settled_fee + self.input_fee_1 + self.input_fee_2 + self.input_fee_3
  end
  def sum_2
    self.cash + self.deposits + self.goods_fee + self.short_fee + self.other_fee
  end
  def sum_3
    self.black_bills + self.red_bills + self.yellow_bills + self.green_bills + self.blue_bills + self.white_bills
  end
  def sum_4
    self.current_debt + self.current_debt_2_3 + self.current_debt_4_5 + self.current_debt_ge_6
  end
end
