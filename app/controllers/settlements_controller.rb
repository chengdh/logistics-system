class SettlementsController < BaseController
  include BillOperate
  def new
    @settlement = Settlement.new
    @settlement = Settlement.new_with_org_id if params[:settlement].present?
  end
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search",:object => @search
  end
end

