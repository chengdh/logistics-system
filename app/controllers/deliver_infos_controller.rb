class DeliverInfosController < BaseController
  table :org,:deliver_date,:customer_name,:customer_no,:sum_carrying_fee,:sum_goods_fee,:sum_th_fee
  include BillOperate
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search",:object => @search
  end

end
