class SettlementsController < BaseController
  def new
    @settlement = Settlement.new
    @settlement = Settlement.new_with_org_id if params[:settlement].present?
  end
  def create
    @settlement = Settlement.new(params[:settlement])
    @settlement.carrying_bill_ids  = params[:bill_ids]  unless params[:bill_ids].blank?
    @settlement.process
    create!
  end

end

