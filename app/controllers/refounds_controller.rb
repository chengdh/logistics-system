#coding: utf-8
class RefoundsController < BaseController
  def create
    @refound = Refound.new(params[:refound])
    @refound.carrying_bill_ids  = params[:bill_ids]  unless params[:bill_ids].blank?
    @refound.process
    create!
  end
  #PUT/:load_list_id/process_handle
  def process_handle

    @refound = Refound.find(params[:id])
    @refound.process ? flash[:success] = "返款清单处理成功!" : flash[:error] = "返款清单处理失败!"
    redirect_to  @refound
  end

end
