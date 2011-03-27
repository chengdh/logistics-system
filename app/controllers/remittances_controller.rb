#coding: utf-8
class RemittancesController < BaseController
  table :bill_date,:from_org,:to_org,:should_fee,:act_fee,:human_state_name,:note
  def update
    @remittance = Remittance.find(params[:id])
    @remittance.process
    update!
  end
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search",:object => @search
  end
end
