#coding: utf-8
module BillOperate
  def create
    bill = resource_class.new(params[resource_class.model_name.underscore])
    instance_variable_set("@#{resource_class.model_name.underscore}",bill)
    bill.carrying_bill_ids  = params[:bill_ids]  unless params[:bill_ids].blank?
    bill.process
    create!
  end
  #PUT/:load_list_id/process_handle
  def process_handle
    bill = resource_class.find(params[:id])
    instance_variable_set("@#{resource_class.model_name.underscore}",bill)
    bill.process ? flash[:success] = "数据处理成功!" : flash[:error] = "数据处理失败!"
    redirect_to  bill
  end
end
