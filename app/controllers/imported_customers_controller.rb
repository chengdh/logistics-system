#coding: utf-8
class ImportedCustomersController < BaseController
  #检查上月是否有数据导入
  before_filter :check_data,:only => :index
  def create
    CustomerFeeInfo.generate_data(params[:org_id])
    flash[:success] = "生成客户分级数据完毕"
    redirect_to imported_customers_url("search[org_id_eq]" => params[:org_id])
  end
  private
  def check_data
    return if params[:search].blank?
    conditions = {:mth => 1.months.ago.strftime('%Y%m'),:org_id => current_user.current_ability_org_ids}
    conditions[:org_id] = params[:search][:org_id_eq] if params[:search][:org_id_eq].present?
    if !CustomerFeeInfo.exists?(conditions)
      flash[:alert] = "没有生成#{1.months.ago.strftime('%Y%m')}月的客户分级信息,请先生成客户分级信息"
    end
  end
end
