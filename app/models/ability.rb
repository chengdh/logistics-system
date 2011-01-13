class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :index,:show,:search,:to => :read
    alias_action :process_handle,:to => :ship  #发车
    alias_action :process_handle,:to => :reach #到货确认
    if user.is_admin?
      can :manage, :all
    else
      #carrying_bill是基类,设定用户可进行一切操作
      can :read,CarryingBill
      user.default_role.role_system_functions.where(:is_select => true).each do |rsf| 
        f_obj = rsf.system_function.function_obj
        if f_obj[:conditions].present?
          can f_obj[:action],f_obj[:subject].constantize ,eval(f_obj[:conditions]) 
        else
          can f_obj[:action],f_obj[:subject].constantize
        end
      end
    end
  end
end
