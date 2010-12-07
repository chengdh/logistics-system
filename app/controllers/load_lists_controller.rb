#coding: utf-8
class LoadListsController < BaseController
  def create
    @load_list = LoadList.new(params[:load_list])
    @load_list.carrying_bill_ids  = params[:bill_ids]  unless params[:bill_ids].blank?
    @load_list.process
    create!
  end
  #PUT/:load_list_id/process_handle
  def process_handle
    @load_list = LoadList.find(params[:id])
    @load_list.process ? flash[:success] = "装车单处理成功!" : flash[:error] = "装车单处理失败!"
    redirect_to  @load_list
  end
end
