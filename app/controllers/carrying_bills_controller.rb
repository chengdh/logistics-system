#coding: utf-8
class CarryingBillsController < BaseController
   belongs_to :load_list, :optional => true

  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "shared/carrying_bills/search",:object => @search
  end
end
