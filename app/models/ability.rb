class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_admin?
      can :manage, :all
    else
      user.default_role.role_system_functions.where(:is_select => true).each do |rsf| 
        f_obj = rsf.system_function.function_obj
        can f_obj[:action],f_obj[:subject].constantize,f_obj[:conditions]
      end
    end
  end
end
