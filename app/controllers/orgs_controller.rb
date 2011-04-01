#coding: utf-8
class OrgsController < BaseController
  #使用http缓存数据到客户端
  #http_cache :index,:last_modified => Proc.new {|c| c.send(:last_modified,Org.order('updated_at DESC').first)},:etag => Proc.new {|c| c.send(:etag,"org_index")}
  #提取所有机构
  def index
    @orgs = Org.where(:is_active => true).order('parent_id ASC,created_at DESC')
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
