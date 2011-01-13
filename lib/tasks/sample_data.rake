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
    #客户资料
    50.times do |index|
      Vip.create!(:name => "vip_#{index}",:phone => ("%07d" % index),:bank => Bank.first,:bank_card =>"%019d" % (index + 1),:org => Branch.first,:id_number => "%018d" % (index + 1) )
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
    role.role_system_functions.each { |role_function| role_function.is_select = true }
    role.save!
    role = Role.new_with_default(:name => 'role_2')
    role.role_orgs.each { |role_org| role_org.is_select = true }
    role.role_system_functions.each { |role_function| role_function.is_select = true }
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
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
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
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
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
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
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
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
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
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:from_org_id => user.default_org.id }"} ,
      :create => {:title => "新建"},
      :search => {:title => "查询"},
      :export => {:title => "导出"},
      :ship => {:title => "发车",:conditions =>"{:from_org_id => user.default_org.id,:state => 'loaded'}"},
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################货物运输清单管理#############################################
    #FIXME 与load_list是相同的,不过仅仅重新派生了一个controller
    subject_title = "到货清单管理"
    subject = "LoadList"
    sf_hash = {
      :group_name => group_name,
      #TODO 提货信息表要添加提货部门字段
      :subject_title => subject_title,
      :subject => subject,
      :function => {
      :read_arrive =>{:title => "查看",:conditions =>"{:state => ['shipped','reached'],:to_org_id => user.default_org.id}"} ,
      :export => {:title => "导出"},
      :reach => {:title => "到货确认",:conditions =>"{:state => 'shipped',:to_org_id => user.default_org.id}"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################分货物清单管理#############################################
    subject_title = "分货清单管理"
    subject = "DistributionList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.default_org.id }"} ,
      :create => {:title => "新建"},
      :search => {:title => "查询"},
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
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.default_org.id }"},
      :create => {:title => "新建"},
      :batch_deliver => {:title => "批量提货"},
      :print => {:title => "打印提货"},
      :search => {:title => "查询"},
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
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.default_org.id }"},
      :create => {:title => "新建"},
      :search => {:title => "查询"},
      :export => {:title => "导出"},
    }

    }
    SystemFunction.create_by_hash(sf_hash)
  end

end
