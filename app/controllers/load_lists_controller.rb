#coding: utf-8
class LoadListsController < BaseController
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
    end
  end
end
