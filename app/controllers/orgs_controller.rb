#coding: utf-8
class OrgsController < BaseController
  #提取所有机构
  def index
    @orgs = Org.search(:is_active_eq => true)
  end
  def new
    get_resource_ivar || set_resource_ivar(resource_class.new_with_config(params[resource_class.model_name.underscore.to_sym]))
    render :partial => "form"
  end
  def edit
    get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    render :partial => "form"
  end
end
