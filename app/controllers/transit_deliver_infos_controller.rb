#coding: utf-8
class TransitDeliverInfosController < BaseController
  def create
    @transit_deliver_info = TransitDeliverInfo.new(params[:transit_deliver_info])
    @transit_deliver_info.carrying_bill = CarryingBill.find(params[:bill_ids].first) unless params[:bill_ids].blank?
    @transit_deliver_info.process
    create!
  end
end
