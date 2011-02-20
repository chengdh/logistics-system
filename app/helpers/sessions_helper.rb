#coding: utf-8
#coding: utf-8
module SessionsHelper
  def user_roles_for_select(user)
    ret = user.roles.where(:is_active => true).all.map {|r| [r.name,r.id]} if user.present?
    ret = Role.where(:is_active => true).all.map {|r| [r.name,r.id]} if user.is_admin?
    ret
  end

  def role_orgs_for_select(role,is_admin = false)
    if is_admin
      Org.where(:is_active => true).all.map{|r| [r.name,r.id]}
    else
      role.orgs.where(:is_active => true).all.map{|r| [r.name,r.id]} if role.present?
    end
  end
  def cur_role
    ret = nil
    ret = Role.find_by_id(session[:cur_role_id]) if session[:cur_role_id].present?
    ret
  end
  def cur_org
    nil
    Org.find_by_id(session[:cur_org_id]) if session[:cur_org_id].present?
  end
end
