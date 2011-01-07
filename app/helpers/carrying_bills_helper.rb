#coding: utf-8
module CarryingBillsHelper
  #运费支付方式显示
  def pay_type_des(pay_type)
    pay_type_des = ""
    CarryingBill.pay_types.each {|des,code| pay_type_des = des if code == pay_type }
    pay_type_des
  end
  #得到查询对象的id数组
  def search_ids
    @search.select("carrying_bills.id").map {|bill| bill.id }.to_json
  end
  #得到票据合计信息
  def search_sum
    sum_info = {
      :count => @search.count,
      :sum_carrying_fee => @search.relation.sum(:carrying_fee),
      #TODO 
      #现金付运费合计
      :sum_carrying_fee_cash => @search.where(:pay_type => CarryingBill::PAY_TYPE_CASH).sum(:carrying_fee),
      #提货付运费合计
      :sum_carrying_fee_th => @search.where(:pay_type => CarryingBill::PAY_TYPE_TH).sum(:carrying_fee),
      #回执付运费合计
      :sum_carrying_fee_re => @search.where(:pay_type => CarryingBill::PAY_TYPE_RETURN).sum(:carrying_fee),
      #自货款扣除运费合计
      :sum_k_carrying_fee => @search.where(:pay_type => CarryingBill::PAY_TYPE_K_GOODSFEE).sum(:carrying_fee),
      #扣手续费合计
      :sum_k_hand_fee => @search.relation.sum(:k_hand_fee),
      :sum_goods_fee => @search.relation.sum(:goods_fee),
      :sum_insured_fee => @search.relation.sum(:insured_fee),
      :sum_transit_carrying_fee => @search.relation.sum(:transit_carrying_fee),
      :sum_transit_hand_fee => @search.relation.sum(:transit_hand_fee),
      :sum_from_short_carrying_fee => @search.relation.sum(:from_short_carrying_fee),
      :sum_to_short_carrying_fee => @search.relation.sum(:to_short_carrying_fee),
      :sum_goods_num => @search.relation.sum(:goods_num)
    }
    #实提货款合计
    sum_info[:sum_act_pay_fee] = sum_info[:sum_goods_fee] - sum_info[:sum_k_carrying_fee] - sum_info[:sum_k_hand_fee]
    sum_info[:sum_agent_carrying_fee] = sum_info[:sum_carrying_fee_th] - sum_info[:sum_transit_carrying_fee]
    sum_info[:sum_th_amount] = sum_info[:sum_agent_carrying_fee] - sum_info[:sum_transit_hand_fee] + sum_info[:sum_goods_fee]+ sum_info[:sum_to_short_carrying_fee]
    sum_info
  end
end
