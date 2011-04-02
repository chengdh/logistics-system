#coding: utf-8
class BaseController < InheritedResources::Base

  authorize_resource

  before_filter :pre_process_search_params,:only => [:index]
  helper_method :sort_column,:sort_direction,:resource_name,:resources_name,:show_view_columns
  respond_to :html,:xml,:js,:json,:csv
  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
  private
  #排序方法
  #见http://asciicasts.com/episodes/228-sortable-table-columns
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"  
  end  
  def sort_column  
    resource_class.column_names.include?(params[:sort]) ? params[:sort] : "#{resource_class.table_name}.created_at"  
  end  
  def show_view_columns
    resource_class.columns.collect{|column| column.name.to_sym  }
  end

  def resource_name
    resource_class.model_name.human
  end

  def resources_name
    resource_name.pluralize
  end
  protected
  #处理查询时,传入的机构代码,如果传入的机构有下级机构,则进行处理
  def pre_process_search_params
    return if params[:search].blank?
    new_search_params ={}
    params[:search].each do |key,value|
      if  ['carrying_bills_from_org_id_eq','carrying_bills_to_org_id_eq','carrying_bills_transit_org_id_eq','carrying_bills_to_org_id_or_transit_org_id_eq',
        'from_org_id_eq','to_org_id_eq','transit_org_id_eq','to_org_id_or_transit_org_id_eq'].include?(key) and value.present? and (the_org = Org.includes(:children).find(value)).children.present?
        change_key = key.to_s.gsub(/_eq/,'_in')
        new_search_params[change_key] = [value] + the_org.children.collect(&:id)
        new_search_params[key]= nil
      end
    end
    params[:search].merge!(new_search_params) if new_search_params.present?
    params[:search]
  end

  protected
  #根据传入参数判断哪个是最近日期,如果什么都不传,则返回当前时间
  def last_modified(objs = [])
    default_array = [current_user,current_user.default_role,current_user.default_org]
    if objs.blank?
      default_array.collect {|obj| obj.send(:updated_at)}.max
    else
      #控制当前页面是否刷新缓存的因素有三个:当前用户/当前用户默认机构/当前用户默认角色,三个页面中任何一个发生改变,都要重新缓存
      tmp_obj = objs.is_a?(Array) ? objs : [objs] 
      (default_array + tmp_obj).collect {|obj| obj.send(:updated_at)}.max
    end
  end
  #生成etag,用于缓存页面
  def etag(prefix = "")
    ret = "#{current_user.id}_#{current_user.default_role}_#{current_user.default_org}"
    ret = "#{prefix}_#{ret}" if prefix.present?
    ret
  end

end
