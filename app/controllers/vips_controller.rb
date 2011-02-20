#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
class VipsController < BaseController
  table :org_id,:code,:name,:phone,:mobile,:bank_id,:bank_card,:address,:company
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search",:object => @search
  end
  def index
    super do |format|
      format.csv {send_data resource_class.to_csv(@search)}
    end
  end
end
