#coding: utf-8
class TransitDeliverInfosController < BaseController
  table :bill_date,:org,:carrying_bill,:transit_hand_fee,:human_state_name,:user,:note
  def create
    @transit_deliver_info = TransitDeliverInfo.new(params[:transit_deliver_info])
    @transit_deliver_info.carrying_bill = CarryingBill.find(params[:bill_ids].first) unless params[:bill_ids].blank?
    @transit_deliver_info.process
    create!
  end
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search",:object => @search
  end

end
