#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
class ReceiveRefoundsController < RefoundsController
  include BillOperate
  defaults :resource_class => Refound, :collection_name => 'refounds', :instance_name => 'refound'
  #先跳过基类的验证,然后重写自己的验证
  skip_authorize_resource
  authorize_resource :class => "Refound",:instance_name => "refound"
  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability,:read_arrive).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end

end
