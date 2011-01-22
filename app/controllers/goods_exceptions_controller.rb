class GoodsExceptionsController < BaseController
  def create
    bill = resource_class.new(params[resource_class.model_name.underscore])
    get_resource_ivar || set_resource_ivar(bill)
    bill.carrying_bill_id  = params[:bill_ids]  unless params[:bill_ids].blank?
    bill.process
    create!
  end

end
