class SettlementsController < BaseController
  include BillOperate
  def new
    @settlement = Settlement.new
    @settlement = Settlement.new_with_org_id if params[:settlement].present?
  end
end

