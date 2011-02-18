class TransferPayInfosController < BaseController
  table :bill_no,:from_customer,:sum_goods_fee,:sum_k_carrying_fee,:sum_k_hand_fee,:sum_act_pay_fee
  include BillOperate
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "shared/pay_infos/search",:object => @search
  end

end
