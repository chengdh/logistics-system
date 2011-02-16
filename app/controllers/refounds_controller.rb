#coding: utf-8
class RefoundsController < BaseController
  include BillOperate
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search",:object => @search
  end

end
