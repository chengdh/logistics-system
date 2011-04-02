#coding: utf-8
module OrgsHelper
  def orgs_for_select
    Org.where(:is_active => true).all.map {|b| ["#{b.name}(#{b.py})",b.id]}
  end

  def branches_for_select
    Branch.where(:is_active => true).all.map {|b| ["#{b.name}(#{b.py})",b.id]}
  end
  #中转中心
  def yards_for_select
    Org.where(:is_active => true,:is_yard => true).all.map {|b| ["#{b.name}(#{b.py})",b.id]}
  end
  #根据当前登录用户的选择机构
  def current_org_for_select
    {current_user.default_org.name => current_user.default_org.id}
  end
  #除去当前机构的机构选择
  def branches_for_select_ex
    Branch.search(:is_active_eq => true,:id_ne => current_user.default_org.id).all.map {|b| ["#{b.name}(#{b.py})",b.id]}
  end

  #当前登录用户可使用的的org
  def current_ability_orgs_for_select
    default_org = current_user.default_org
    ret = ActiveSupport::OrderedHash.new 
    ret["#{default_org.name}(#{default_org.py})"] = default_org.id
    default_org.children.each {|child_org|  ret["#{child_org.name}(#{child_org.py})"] = child_org.id}
    ret
  end

  #当前登录用户可用之外的orgs
  def exclude_current_ability_orgs_for_select
    #除去当前默认org和当前org的上级机构
    default_org_id = current_user.default_org.id
    parent_id = current_user.default_org.parent_id
    exclude_ids =[current_user.default_org.id]
    exclude_ids << parent_id += Org.where(:parent_id => parent_id).collect(&:id) if parent_id.present?
    exclude_ids += Org.where(:parent_id => default_org_id).collect(&:id)
    exclude_ids.uniq!
    Branch.search(:is_active_eq => true,:id_ni => exclude_ids).all.map {|b| ["#{b.name}(#{b.py})",b.id]}
  end
end
