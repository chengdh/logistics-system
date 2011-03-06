#coding: utf-8
class TransferPaymentListsController < BaseController
  table :except => :type
  include BillOperate
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search",:object => @search
  end
  def show
    super do |format|
      format.csv {send_data resource.to_csv}
      #TODO 需明确转账格式
      format.text {send_data '1,2,3',:filename => 'txt_file.txt'}
    end
  end

end
