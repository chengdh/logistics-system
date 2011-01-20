#coding: utf-8 
require 'faker'

namespace :db do
  desc "向数据库中添加示例数据"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    Rake::Task['db:create_system_functions'].invoke
    zz_branch = Branch.create!(:name => "郑州公司",
                               :simp_name => "郑",
                               :manager => "李保庆",
                               :code => "zz",
                               :location => "南四环十八里河")
    ('A'..'Z').each do |n|
      branch = Branch.new(:name => n,:simp_name => n,:code => n)
      zz_branch.children << branch
    end
    %w[
    邱县 焦作 永年 馆陶 三门峡 洛阳 周口 肥乡 广平 成安 长治 石家庄 水冶 偃师 许昌 曲周 濮阳 新乡
    魏县 驻马店 宁晋 晋城 双桥 肉联厂 磁县 漯河 临漳 沙河 涉县 大名 鸡泽 侯马 峰峰 武安 邯郸 邢台].each_with_index do |name,index|
      Branch.create!(:name => name,:simp_name => name.first,:location => name,:code => index + 1)
    end
    #银行信息
    %w[建设银行 工商银行 交通银行 光大银行].each_with_index do  |bank,index|
      Bank.create!(:name => bank,:code => index + 1)
    end
    #转账手续费设置
    common_config = ConfigTransit.create(:name => "普通客户",:rate => 0.002)
    vip_config = ConfigTransit.create(:name => "VIP客户",:rate => 0.001)
    #客户资料
    50.times do |index|
      Vip.create!(:name => "vip_#{index}",:phone => ("%07d" % index),:bank => Bank.first,:bank_card =>"%019d" % (index + 1),:org => Branch.first,:id_number => "%018d" % (index + 1),:config_transit => vip_config )
    end

    #生成示例票据数据
    #各种票据生成50张
    50.times do |index|
      Factory(:computer_bill,:pay_type =>"TH",:from_org => Branch.first,:to_org => Branch.last,:from_customer => Vip.first,:from_customer_name => Vip.first.name,:from_customer_phone => Vip.first.phone)
      Factory(:hand_bill,:from_org => Branch.first,:to_org => Branch.last,:bill_no => "hand_bill_no_#{index}",:goods_no => "hand_goods_no_#{index}")
      Factory(:transit_bill,:from_org => Branch.find_by_py('sjz'),:transit_org => Branch.find_by_py('zzgs'),:to_area => "开封")
      Factory(:hand_transit_bill,:from_org => Branch.find_by_py('sjz'),:transit_org => Branch.find_by_py('zzgs'),:to_area => "开封",:bill_no => "hand_transit_bill_no_#{index}",:goods_no => "hand_transit_goods_no_#{index}")
    end
    10.times do |index|
      TransitCompany.create(:name => "中转公司_#{index}",:address => "中转公司地址_#{index} ")
    end
    role = Role.new_with_default(:name => 'admin_role')
    role.role_orgs.each { |role_org| role_org.is_select = true }
    role.role_system_function_operates.each { |r| r.is_select = true }
    role.save!
    role = Role.new_with_default(:name => 'role_2')
    role.role_orgs.each { |role_org| role_org.is_select = true }
    role.role_system_function_operates.each { |r| r.is_select = true }
    role.save!

    #管理员角色
    admin = User.new_with_roles(:username => 'admin',:password => 'admin',:is_admin => true)
    admin.user_roles.each {|user_role| user_role.is_select = true}
    admin.save!
    #普通用户角色
    user = User.new_with_roles(:username => 'user',:password => 'user')
    user.user_roles.each {|user_role| user_role.is_select = true}
    user.save!
  end
  task :create_system_functions => :environment do

    #配送管理模块
    group_name = "配送管理"
    #################################运单录入################################################
    subject_title = "运单录入"
    subject = "ComputerBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => '/computer_bills/new',
      :function => {
      #查看相关运单,其他机构发往当前用户机构的运单
      :create => {:title => "新建"},
      :update =>{:title =>"修改",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
      :destroy => {:title => "删除",:conditions =>"{:state => ['loaded','billed']}"},
      :print => {:title => "打印"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################手工运单录入#################################################
    subject_title = "手工运单录入"
    subject = "HandBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => '/hand_bills/new',
      :function => {
      :create => {:title => "新建"},
      :update =>{:title =>"修改",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
      :destroy => {:title => "删除",:conditions =>"{:state => ['loaded','billed']}"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################中转运单录入#################################################
    subject_title = "中转运单录入"
    subject = "TransitBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,

      :default_action => '/transit_bills/new',
      :subject => subject,
      :function => {
      :create => {:title => "新建"},
      :update =>{:title =>"修改",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
      :print => {:title => "打印"},
      :destroy => {:title => "删除",:conditions =>"{:state => ['loaded','billed']}"},
      :export => {:title => "导出"}

    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################手工中转运单录入#################################################
    subject_title = "手工中转运单录入"
    subject = "HandTransitBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,

      :default_action => '/hand_transit_bills/new',
      :subject => subject,
      :function => {
      :create => {:title => "新建"},
      :update =>{:title =>"修改",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
      :destroy => {:title => "删除",:conditions =>"{:state => ['loaded','billed']}"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################退货单#################################################
    subject_title = "退货单管理"
    subject = "ReturnBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/return_bills/before_new',
      :subject => subject,
      :function => {
      :create => {:title => "新建"},
      :update =>{:title =>"修改",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
      :destroy => {:title => "删除",:conditions =>"{:state => ['loaded','billed']}"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)

    ##############################货物运输清单管理#############################################
    subject_title = "货物运输清单管理"
    subject = "LoadList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/load_lists',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:from_org_id => user.current_ability_org_ids }"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"},
      :ship => {:title => "发车",:conditions =>"{:from_org_id => user.current_ability_org_ids,:state => 'loaded'}"},
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################到货清单管理#############################################
    #FIXME 与load_list是相同的,不过仅仅重新派生了一个controller
    subject_title = "到货清单管理"
    subject = "LoadList"
    sf_hash = {
      :group_name => group_name,
      #TODO 提货信息表要添加提货部门字段
      :subject_title => subject_title,
      :default_action => '/arrive_load_lists',
      :subject => subject,
      :function => {
      :read_arrive =>{:title => "查看",:conditions =>"{:state => ['shipped','reached'],:to_org_id => user.current_ability_org_ids}"} ,
      :export => {:title => "导出"},
      :reach => {:title => "到货确认",:conditions =>"{:state => 'shipped',:to_org_id => user.current_ability_org_ids}"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################分货物清单管理#############################################
    subject_title = "分货清单管理"
    subject = "DistributionList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/distribution_lists/new',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids}"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"},
    }

    }
    SystemFunction.create_by_hash(sf_hash)
     ##############################货物中转#############################################
    subject_title = "货物中转"
    subject = "TransitInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/transit_infos/new',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids}"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"},
    }

    }
    SystemFunction.create_by_hash(sf_hash)

    ##############################提货#############################################
    subject_title = "客户提货"
    subject = "DeliverInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => '/deliver_infos/new',
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"},
      :create => {:title => "新建"},
      :batch_deliver => {:title => "批量提货"},
      #TODO  
      :print => {:title => "打印提货"},
      :export => {:title => "导出"},
    }

    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################中转提货#############################################
    subject_title = "中转提货"
    subject = "TransitDeliverInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/transit_deliver_infos/new',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids}"},
      :create => {:title => "新建"},
      :export => {:title => "导出"},
    }

    }
    SystemFunction.create_by_hash(sf_hash)

    #################################结算管理##########################################
    group_name = "结算管理"
    ##############################settlement#############################################
    subject_title = "结算员交款清单"
    subject = "Settlement"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/settlements/new',
      :subject => subject,
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"},
      :create => {:title => "新建"},
      :export => {:title => "导出"},
      }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################返款清单管理#############################################
    subject_title = "返款清单管理"
    subject = "Refound"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/refounds/new',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:from_org_id => user.current_ability_org_ids }"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################收款清单管理#############################################
    #FIXME 与返款清单是相同的,不过仅仅重新派生了一个controller
    subject_title = "收款清单管理"
    subject = "Refound"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/receive_refounds',
      :subject => subject,
      :function => {
      :read_arrive =>{:title => "查看",:conditions =>"{:state =>['refunded_confirmed','refunded'] ,:to_org_id => user.current_ability_org_ids}"} ,
      :refound_confirm => {:title => "收款确认",:conditions =>"{:state => 'refunded',:to_org_id => user.current_ability_org_ids}"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################现金代收货款支付清单管理-#############################################
    subject_title = "现金-代收货款支付"
    subject = "CashPaymentList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => '/cash_payment_lists',
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################银行转账代收货款支付清单管理-#############################################
    subject_title = "转账-代收货款支付"
    subject = "TransferPaymentList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/transfer_payment_lists',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################客户提款-现金-#############################################
    subject_title = "客户提款-现金"
    subject = "CashPayInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,

      :default_action => '/cash_pay_infos/new',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
      :batch_pay =>{:title => "批量提款"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################客户提款-转账-#############################################
    subject_title = "客户提款-转账"
    subject = "TransferPayInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,

      :default_action => '/transfer_pay_infos/new',
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
      :batch_pay =>{:title => "批量提款"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################客户提款日结#############################################
    subject_title = "客户提款日结"
    subject = "PostInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/post_infos',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)

    group_name = "基础信息管理"
    #################################分理处/分公司管理################################################
    subject_title = "分理处/分公司管理"
    subject = "Org"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/orgs',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    #################################用户信息管理################################################
    subject_title = "用户信息管理"
    subject = "User"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => '/users',
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    #################################用户角色管理################################################
    subject_title = "用户角色管理"
    subject = "Role"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/roles',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)

    group_name ="客户关系管理"
    #################################客户关系管理################################################
    subject_title = "客户资料管理"
    subject = "Customer"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/customers',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改",:conditions =>"{:org_id => user.current_ability_org_ids }"},
      :destroy => {:title => "删除",:conditions =>"{:org_id => user.current_ability_org_ids }"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)

    #################################客户关系管理################################################
    subject_title = "转账客户管理"
    subject = "Vip"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/vips',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)

    group_name ="系统管理"
    ##################################银行设置###############################################
    subject_title = "银行信息设置"
    subject = "Bank"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/banks',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##################################中转公司信息###############################################
    subject_title = "中转公司信息"
    subject = "TransitCompany"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/transit_companies',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##################################手续费比例设置-现金###############################################
    subject_title = "手续费比例设置-现金"
    subject = "ConfigCash"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/config_cashes',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##################################手续费比例设置-转账###############################################
    subject_title = "手续费比例设置-转账"
    subject = "ConfigTransit"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/config_transits',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##################################系统参数设置###############################################
    subject_title = "系统参数设置"
    subject = "IlConfig"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => '/il_configs',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

end
