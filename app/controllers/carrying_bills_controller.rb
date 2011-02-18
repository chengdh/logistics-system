#coding: utf-8
#运单controller基础类
class CarryingBillsController < BaseController
  skip_authorize_resource :only => :update
  before_filter :pre_process_search_params,:only => [:index,:rpt_turnover,:turnover_chart]
  belongs_to :load_list,:distribution_list,:deliver_info,:settlement,:refound,:cash_payment_list,:transfer_payment_list,:cash_pay_info,:transfer_pay_info,:post_info,:polymorphic => true,:optional => true

  #覆盖默认的index方法,主要是为了导出
  def index
    super do |format|
      format.csv {send_data resource_class.to_csv(@search)}
    end
  end

  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "shared/carrying_bills/search",:object => @search
  end
  #简单查询,用于报表统计
  def simple_search
    @search = resource_class.search(params[:search])
  end
  def show
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    respond_with(bill) do |format|
      format.html
      format.js { render :partial => "shared/carrying_bills/show",:object => bill}
    end
  end
  #重写修改方法
  def update
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    bill.attributes=params[resource_class.model_name.underscore.to_sym]
    authorize! :update,bill
    update!
  end

  #PUT /carrying_bills/1/reset
  def reset
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    bill.reset
    flash[:success] = "运单已成功重置."
    redirect_to bill
  end
  #日/月营业额统计
  def rpt_turnover
    @search = resource_class.accessible_by(current_ability).turnover.search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.all)
  end
  #营业额统计柱状图
  def turnover_chart
    @search = resource_class.accessible_by(current_ability).turnover.search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.all)
  end
end
