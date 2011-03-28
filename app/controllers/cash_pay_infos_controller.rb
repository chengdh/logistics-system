#coding: utf-8
class CashPayInfosController < BaseController
  table :bill_no,:from_customer,:sum_goods_fee,:sum_k_carrying_fee,:sum_k_hand_fee,:sum_act_pay_fee
  include BillOperate
  #GET search
  #显示查询窗口
  def search
    render :partial => "shared/pay_infos/search"
  end
  def index
    super do |format|
      format.csv {send_data resource_class.to_csv(@search)}
    end
  end

end
