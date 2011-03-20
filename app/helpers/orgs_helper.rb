#coding: utf-8
module OrgsHelper
  def orgs_for_select
    Org.where(:is_active => true).all.map {|b| ["#{b.name}(#{b.py})",b.id]}
  end

  def branches_for_select
    Branch.where(:is_active => true).all.map {|b| ["#{b.name}(#{b.py})",b.id]}
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

    default_org = current_user.default_org
    exclude_org_ids = [default_org.id]
    if default_org.parent.present?
      default_org.parent.children.each {|child_org| exclude_org_ids += [child_org.id]}  
      exclude_org_ids += [default_org.parent.id]
    end
    if default_org.children.present?
      default_org.children.each {|child_org| exclude_org_ids += [child_org.id]}  
    end

    exclude_org_ids.uniq!
    Branch.search(:is_active_eq => true,:id_ni => exclude_org_ids).all.map {|b| ["#{b.name}(#{b.py})",b.id]}
  end
end
