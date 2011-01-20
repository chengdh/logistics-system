class OrgsController < BaseController
  def new
    get_resource_ivar || set_resource_ivar(resource_class.new(params[resource_class.model_name.underscore.to_sym]))
    render :partial => "form"
  end
  def edit
    get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    render :partial => "form"
  end
end
