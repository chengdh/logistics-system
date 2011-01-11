#coding: utf-8
class BaseController < InheritedResources::Base
  before_filter :authenticate_user!
  helper_method :sort_column,:sort_direction,:resource_name,:resources_name,:show_view_columns

  respond_to :html,:xml,:js,:json
  protected
  def collection
    @search = end_of_association_chain.search(params[:search])
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
end
