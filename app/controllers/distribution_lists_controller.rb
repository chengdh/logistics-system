class DistributionListsController < BaseController
  def create
    @distribution_list = DistributionList.new(params[:distribution_list])
    @distribution_list.carrying_bill_ids  = params[:bill_ids]  unless params[:bill_ids].blank?
    @distribution_list.process
    create!
  end
end

