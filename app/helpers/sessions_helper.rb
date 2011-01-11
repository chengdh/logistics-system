module SessionsHelper
  def user_roles_for_select(user)
    user.roles.where(:is_active => true).all.map {|r| [r.name,r.id]} if user.present?
    Role.where(:is_active => true).all.map {|r| [r.name,r.id]} if user.is_admin?
  end

  def role_orgs_for_select(role,is_admin = false)
    if is_admin
      Org.where(:is_active => true).all.map{|r| [r.name,r.id]}
    else
      role.orgs.where(:is_active => true).all.map{|r| [r.name,r.id]} if role.present?
    end
  end
end
