#coding: utf-8
class LoadListsController < BaseController
  def before_create
    @load_list = LoadList.new(params[:load_list])
    @load_list.carrying_bills << CarryingBill.find(params[:bill_ids])
  end
end
