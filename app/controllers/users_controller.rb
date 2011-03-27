#coding: utf-8
class UsersController < BaseController
  table :username,:is_active,:is_admin,:default_org_id,:default_role_id,:current_sign_in_at,:last_sign_in_at,:current_sign_in_ip,:last_sign_in_ip
  def new
    @user = User.new_with_roles
  end
  def edit
    @user = User.with_association.find(params[:id])
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
  #GET users/:id/reset_usb_pin
  #重设usb pin
  def reset_usb_pin
    @user = User.find(params[:id])
    @user.set_usb_pin
    flash[:success]="已重新设置了用户的usb pin,请点击保存按钮更新ukey!"
    render :edit
  end
end
