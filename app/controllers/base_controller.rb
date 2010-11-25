#coding: utf-8
class BaseController < InheritedViews::Base
  helper_method :sort_column,:sort_direction
  respond_to :html,:xml,:js,:json
  protected
  def collection
    search = end_of_association_chain.search(params[:search])
    get_collection_ivar || set_collection_ivar(search.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
  private
  #排序方法
  #见http://asciicasts.com/episodes/228-sortable-table-columns
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"  
  end  
  def sort_column  
    resource_class.column_names.include?(params[:sort]) ? params[:sort] : "created_at"  
  end  
end
