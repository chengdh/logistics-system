#coding: utf-8
class LoadListsController < BaseController
  def create
    bills = CarryingBill.find(params[:bill_ids])
    @load_list = LoadList.new(params[:load_list])
    @load_list.carrying_bills << bills
    @load_list.process
    create!
  end
end
