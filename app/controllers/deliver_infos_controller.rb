class DeliverInfosController < BaseController
  def create
    @deliver_info= DeliverInfo.new(params[:deliver_info])
    @deliver_info.carrying_bill_ids  = params[:bill_ids]  unless params[:bill_ids].blank?
    @deliver_info.process
    create!
  end

end
