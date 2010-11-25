#coding: utf-8
class CarryingBillsController < BaseController
  #GET search
  #显示查询窗口
  def search
     render :partial => "shared/carrying_bills/search",:object => @search
  end
end
