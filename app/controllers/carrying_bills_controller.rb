#coding: utf-8
class CarryingBillsController < BaseController
  belongs_to :load_list,:distribution_list,:deliver_info,:settlement,:refound,:cash_payment_list,:transfer_payment_list,:cash_pay_info,:transfer_pay_info,:post_info,:polymorphic => true,:optional => true
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "shared/carrying_bills/search",:object => @search
  end
  def show
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    respond_with(bill) do |format|
      format.html
      format.js { render :partial => "shared/carrying_bills/show",:object => bill}
    end
  end
end
