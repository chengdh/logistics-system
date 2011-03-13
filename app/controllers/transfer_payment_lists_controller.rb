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
      format.csv {send_data resource.to_csv,:filename => '浦发批量转账文件.csv'}
      format.text {send_data resource.ccb_to_txt,:filename => '建行批量转账文件.txt'}
    end
  end
end
