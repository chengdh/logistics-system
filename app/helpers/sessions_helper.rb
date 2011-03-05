#coding: utf-8
module SessionsHelper
  def user_roles_for_select(user)
    ret = user.roles.where(:is_active => true).all.map {|r| [r.name,r.id]} if user.present?
    ret = Role.where(:is_active => true).all.map {|r| [r.name,r.id]} if user.is_admin?
    ret
  end

  def user_orgs_for_select(user)
    if user.is_admin
      Org.where(:is_active => true).all.map{|r| [r.name,r.id]}
    else
      user.orgs.where(:is_active => true).all.map{|r| [r.name,r.id]}
    end
  end
end
