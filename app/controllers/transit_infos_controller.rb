class TransitInfosController < BaseController
  def create
    @transit_info = TransitInfo.new(params[:transit_info])
    @transit_info.carrying_bill = CarryingBill.find(params[:bill_ids].first) unless params[:bill_ids].blank?
    @transit_info.process
    create!
  end

  def new
    @transit_info = TransitInfo.new(params[:transit_info])
    @transit_info.transit_company = TransitCompany.new
  end
end
