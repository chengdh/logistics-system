class RolesController < BaseController
  def new
    @role = Role.new_with_default
  end
  #登录界面,角色选择发生变化
  #GET roles/current_role_change
  def current_role_change
  end
end
