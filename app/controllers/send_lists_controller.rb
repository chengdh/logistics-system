class SendListsController < BaseController
  def create
    bill = resource_class.new(params[resource_class.model_name.underscore])
    get_resource_ivar || set_resource_ivar(bill)
    if params[:bill_ids].present? 
      params[:bill_ids].each do |bill_id|
        bill.send_list_lines.build(:carrying_bill_id => bill_id)
      end
    end
    create!
  end
end
