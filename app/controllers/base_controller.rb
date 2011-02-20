#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
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
  private
  #处理查询时,传入的机构代码,如果传入的机构有下级机构,则进行处理
  def pre_process_search_params
    return if params[:search].blank?
    new_search_params ={}
    params[:search].each do |key,value|
      if  ['carrying_bills_from_org_id_eq','carrying_bills_to_org_id_eq','carrying_bills_transit_org_id_eq','carrying_bills_to_org_id_or_transit_org_id_eq',
        'from_org_id_eq','to_org_id_eq','transit_org_id_eq','to_org_id_or_transit_org_id_eq'].include?(key) and value.present? and Org.find(value).children.present?
        change_key = key.to_s.gsub(/_eq/,'_in')
        new_search_params[change_key] = [value] + Org.find(value).children.collect {|child_org| child_org.id}
        new_search_params[key]= nil
      end
    end
    params[:search].merge!(new_search_params) if new_search_params.present?
  end
end
