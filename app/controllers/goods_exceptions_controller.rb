class GoodsExceptionsController < BaseController
  #需要跳过对update的权限检查,在进行核销/理赔/责任鉴定时候,使用了update
  skip_authorize_resource :only => :update
  def create
    bill = resource_class.new(params[resource_class.model_name.underscore])
    get_resource_ivar || set_resource_ivar(bill)
    bill.carrying_bill_id  = params[:bill_ids].first  unless params[:bill_ids].blank?
    create!
  end
  def update
    bill = resource_class.find(params[:id])
    get_resource_ivar || set_resource_ivar(bill)
    bill.process
    update!
  end

  #GET /goods_exceptions/1/show_authorize
  #显示授权核销界面
  def show_authorize
    goods_exception = resource_class.find(params[:id])
    get_resource_ivar || set_resource_ivar(goods_exception)
    goods_exception.build_gexception_authorize_info
  end
  #GET /goods_exceptions/1/show_claim
  #显示理赔界面
  def show_claim
    goods_exception = resource_class.find(params[:id])
    get_resource_ivar || set_resource_ivar(goods_exception)
    goods_exception.build_claim
  end
  #GET /goods_exceptions/1/show_identify
  #显示责任鉴定界面
  def show_identify
    goods_exception = resource_class.find(params[:id])
    get_resource_ivar || set_resource_ivar(goods_exception)
    goods_exception.build_goods_exception_identify
  end
end
