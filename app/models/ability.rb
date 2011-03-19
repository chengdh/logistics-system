#coding: utf-8
class Ability
  include CanCan::Ability

  def initialize(user)
    #search simple_search 都看作是read权限
    #rpt_turnover运单统计
    #turnover_chart运单统计图
    alias_action :index,:show,:search,:simple_search,:export_excel,:rpt_turnover,:turnover_chart,:to => :read
    #before_new是新建退货单的初始页面
    alias_action :new,:before_new,:to => :create
    alias_action :process_handle,:to => :ship  #发车
    alias_action :process_handle,:to => :reach #到货确认
    alias_action :process_handle,:to => :refounc_confirm #收款清单确认
    #user 重设置usb key
    alias_action :reset_usb_pin,:to => :edit #重设usb pin




    if user.is_admin?
      #先定义可操作所有权限,在下边对权限进行覆盖
      can :read,:all
      can :create,:all
      can :edit,:all
      can :destroy,:all

      SystemFunctionOperate.all.each do |sfo| 
        f_obj = sfo.function_obj
        if f_obj[:conditions].present?
          can f_obj[:action],f_obj[:subject].constantize ,eval(f_obj[:conditions]) 
        else
          can f_obj[:action],f_obj[:subject].constantize
        end
      end
    else
      user.default_role.system_function_operates.each do |sfo| 
        f_obj = sfo.function_obj
        the_model_class = f_obj[:subject].constantize
        if f_obj[:conditions].present?
          can f_obj[:action],the_model_class ,eval(f_obj[:conditions]) 
        else
          can f_obj[:action],the_model_class
        end
        #默认情况下,如果有create,edit权限,则默认具备read权限
        if can?(:create,the_model_class) or can?(:edit,the_model_class) or can?(:update,the_model_class)
          can :read,the_model_class
        end
      end
    end

    #设定用户对运单的操作权限
    ability_org_ids = user.current_ability_org_ids

    #定义运单的读权限
    can :read,CarryingBill,['from_org_id in (?) or transit_org_id in (?) or to_org_id in (?)',ability_org_ids,ability_org_ids,ability_org_ids] do |bill|
      ability_org_ids.include?(bill.from_org_id) or ability_org_ids.include?(bill.to_org_id) or ability_org_ids.include?(bill.transit_org_id)
    end
    #登录时,可操作current_role_change action
    can :current_role_change,Role
    #登录后,可修改自身密码
    can :edit_password,User
    #可更新自身密码
    can :update_password,User


    #以下重新定义运单修改权限
    #重新设置运单不可修改
    cannot :update,CarryingBill
    #可修改20%运费
    if can? :update_carrying_fee_20,CarryingBill
      can :update,CarryingBill do |bill|
        (bill.original_carrying_fee - bill.carrying_fee)/bill.original_carrying_fee <= 0.2
      end
    end
    #可修改50%运费
    if can? :update_carrying_fee_50,CarryingBill
      can :update,CarryingBill do |bill|
        (bill.original_carrying_fee - bill.carrying_fee)/bill.original_carrying_fee <= 0.5
      end
    end
    #可修改100%运费
    if can? :update_carrying_fee_100,CarryingBill
      can :update,CarryingBill do |bill|
        (bill.original_carrying_fee - bill.carrying_fee) >= 0
      end
    end
    #可修改全部运单字段
    if can? :update_all,CarryingBill
      can :update,CarryingBill,:from_org_id => user.current_ability_org_ids
    end

  end
end
