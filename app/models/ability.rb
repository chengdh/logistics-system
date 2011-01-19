class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :index,:show,:search,:to => :read
    #before_new是新建退货单的初始页面
    alias_action :new,:before_new,:to => :create
    alias_action :process_handle,:to => :ship  #发车
    alias_action :process_handle,:to => :reach #到货确认
    alias_action :process_handle,:to => :refounc_confirm #收款清单确认
    if user.is_admin?
      can :manage, :all
    else
      #设定用户对运单的操作权限
      ability_org_ids = user.current_ability_org_ids
      can :read,CarryingBill,['from_org_id in (?) or transit_org_id in (?) or to_org_id in (?)',ability_org_ids,ability_org_ids,ability_org_ids] do |bill|
        ability_org_ids.include?(bill.from_org_id) or ability_org_ids.include?(bill.to_org_id) or ability_org_ids.include?(bill.transit_org_id)
      end
      user.default_role.system_function_operates.each do |sfo| 
        f_obj = sfo.function_obj
        if f_obj[:conditions].present?
          can f_obj[:action],f_obj[:subject].constantize ,eval(f_obj[:conditions]) 
        else
          can f_obj[:action],f_obj[:subject].constantize
        end
      end
    end
  end
end
