#coding: utf-8
class TransitInfosController < BaseController
  table :bill_date,:org,:transit_company,:transit_carrying_fee,:carrying_bill
  def create
    @transit_info = TransitInfo.new(params[:transit_info])
    @transit_info.carrying_bill = CarryingBill.find(params[:bill_ids].first) unless params[:bill_ids].blank?
    @transit_info.process
    create!
  end

  def new
    @transit_info = TransitInfo.new(params[:transit_info])
    @transit_info.transit_company = TransitCompany.new
  end
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
end
