#coding: utf-8
class UsersController < BaseController
  table :username,:is_active,:is_admin,:default_org_id,:default_role_id,:current_sign_in_at,:last_sign_in_at,:current_sign_in_ip,:last_sign_in_ip
  def new
    @user = User.new_with_roles
  end
  # GET users/edit_password
  # 修改当前登录用户的密码
  def edit_password
  end
  def update_password
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success]="更新密码成功!"
      render :show
    else
      flash[:error]="更新密码失败!"
      render :edit_password
    end
  end
end
