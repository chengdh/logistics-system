#coding: utf-8 
require 'faker'

namespace :db do
  desc "对carrying_bills表进行分表操作"
  task :partition_carrying_bills => :environment do
    c = ActiveRecord::Base.connection
    #修改carrying_bill id的定义,便于进行分表操作


    c.execute("ALTER TABLE carrying_bills MODIFY id INT(11) NOT NULL")
    c.execute("ALTER TABLE carrying_bills DROP PRIMARY KEY")
    c.execute("ALTER TABLE carrying_bills ADD PRIMARY KEY (id,completed)")
    c.execute("ALTER TABLE carrying_bills MODIFY id INT(11) NOT NULL AUTO_INCREMENT")

    #以下添加mysql 分区表
    c.execute("ALTER TABLE carrying_bills 
            partition by list(completed)
            (
            partition p0 values in(0),
            partition p1 values in(1)
           )")

  end
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
      Factory(:computer_bill,:pay_type =>"TH",:from_org => Org.find_by_py('A'),:to_org => Org.find_by_py('hd'),:from_customer => Vip.first,:from_customer_name => Vip.first.name,:from_customer_phone => Vip.first.phone)
      Factory(:computer_bill,:pay_type =>"TH",:from_org => Org.find_by_py('B'),:to_org => Org.find_by_py('qx'),:from_customer => Vip.first,:from_customer_name => Vip.first.name,:from_customer_phone => Vip.first.phone)
      Factory(:computer_bill,:pay_type =>"TH",:from_org => Org.find_by_py('C'),:to_org => Org.find_by_py('dm'),:from_customer => Vip.first,:from_customer_name => Vip.first.name,:from_customer_phone => Vip.first.phone)
      Factory(:computer_bill,:pay_type =>"TH",:from_org => Org.find_by_py('D'),:to_org => Org.find_by_py('xc'),:from_customer => Vip.first,:from_customer_name => Vip.first.name,:from_customer_phone => Vip.first.phone)
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

    #送货人
    Sender.create(:name => "张三",:mobile => "1212121",:org => Org.find_by_py('xt'))
    Sender.create(:name => "李四",:mobile => "1212121",:org => Org.find_by_py('zzgs'))
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
      :default_action => 'new_computer_bill_path',
      :function => {
      #查看相关运单,其他机构发往当前用户机构的运单
      :create => {:title => "新建"},
      :update =>{:title =>"修改",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
      :destroy => {:title => "删除",:conditions =>"{:state => ['loaded','billed']}"},
      :re_print => {:title => "票据重打",:conditions =>"{:state => 'billed'}"},
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
      :default_action => 'new_hand_bill_path',
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

      :default_action => 'new_transit_bill_path',
      :subject => subject,
      :function => {
      :create => {:title => "新建"},
      :update =>{:title =>"修改",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
      :re_print => {:title => "票据重打",:conditions =>"{:state => 'billed'}"},
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

      :default_action => 'new_hand_transit_bill_path',
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
      :default_action => 'before_new_return_bills_path',
      :subject => subject,
      :function => {
      :create => {:title => "新建"},
      :update =>{:title =>"修改",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
      :destroy => {:title => "删除",:conditions =>"{:state => ['loaded','billed']}"},
      :re_print => {:title => "票据重打",:conditions =>"{:state => 'billed'}"},
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
      :default_action => 'load_lists_path',
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
      :subject_title => subject_title,
      :default_action => 'arrive_load_lists_path',
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
      :default_action => 'new_distribution_list_path',
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
      :default_action => 'new_transit_info_path',
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
      :default_action => 'new_deliver_info_path',
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"},
      :create => {:title => "新建"},
      :batch_deliver => {:title => "批量提货"},
      :print_deliver => {:title => "打印提货"},
      :print => {:title => "仅打印提货单"},
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
      :default_action => 'new_transit_deliver_info_path',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids}"},
      :create => {:title => "新建"},
      :export => {:title => "导出"},
    }

    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################短途运费管理#############################################
    subject_title = "短途运费管理"
    subject = "ShortFeeInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'new_short_fee_info_path',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ############################################################################################
    group_name = "查询统计"
    ##############################运单查询/修改#################################################
    subject_title = "运单查询/修改"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'carrying_bills_path',
      :subject => subject,
      :function => {
      :read => {:title => "查询/查看",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
      :update_carrying_fee_20 =>{:title =>"修改运费(20%)"},
      :update_carrying_fee_50 =>{:title =>"修改运费(50%)"},
      :update_carrying_fee_100 =>{:title =>"修改运费(100%)"},
      :update_all =>{:title =>"修改运单全部信息"},
      :reset =>{:title =>"重置运单",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)

    ##############################未提货统计#############################################
    subject_title = "未提货报表"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_no_delivery",:show_fields =>".stranded_days",:hide_fields => ".insured_fee","search[state_in]" => ["reached","distributed"],"search[from_org_id_eq]" => current_user.default_org.id )',
      :subject => subject,
      :function => {
      :rpt_no_delivery =>{:title =>"未提货报表"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################本地未提货统计#############################################
    subject_title = "本地未提货统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_no_delivery",:show_fields =>".stranded_days",:hide_fields => ".insured_fee","search[state_in]" => ["reached","distributed"],"search[to_org_id_eq]" => current_user.default_org.id )',
      :subject => subject,
      :function => {
      :rpt_no_delivery =>{:title =>"本地未提货统计"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################始发地收货统计#############################################
    subject_title = "始发地收货统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_to_me","search[to_org_id_eq]" => current_user.default_org.id,"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day)',
      :subject => subject,
      :function => {
      :rpt_to_me =>{:title =>"始发地收货统计"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################日营业额统计#############################################
    subject_title = "日营业额统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'rpt_turnover_carrying_bills_path("search[type_in]" => ["ComputerBill","HandBill","ReturnBill"],"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day)',
      :subject => subject,
      :function => {
      :rpt_to_me =>{:title =>"日营业额统计"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################日营业额统计图#############################################
    subject_title = "日营业额统计图"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'turnover_chart_carrying_bills_path("search[type_in]" => ["ComputerBill","HandBill","ReturnBill"],"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day)',
      :subject => subject,
      :function => {
      :turnover_chart =>{:title =>"日营业额统计图"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################月营业额统计#############################################
    subject_title = "月营业额统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'rpt_turnover_carrying_bills_path("search[type_in]" => ["ComputerBill","HandBill","ReturnBill"],"search[bill_date_gte]" => Date.today.beginning_of_month,"search[bill_date_lte]" => Date.today.end_of_month)',
      :subject => subject,
      :function => {
      :rpt_to_me =>{:title =>"月营业额统计"}
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
      :default_action => 'new_settlement_path',
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
      :default_action => 'new_refound_path',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:from_org_id => user.current_ability_org_ids }"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################汇款记录#############################################
    subject_title = "汇款记录"
    subject = "Remittance"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'remittances_path',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:from_org_id => user.current_ability_org_ids }"} ,
      :update => {:title => "录入汇款记录",:conditions =>"{:state =>'draft' ,:from_org_id => user.current_ability_org_ids }"}
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
      :default_action => 'receive_refounds_path',
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
      :default_action => 'cash_payment_lists_path',
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
      :default_action => 'transfer_payment_lists_path',
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

      :default_action => 'new_cash_pay_info_path',
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

      :default_action => 'new_transfer_pay_info_path',
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
      :default_action => 'post_infos_path',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
      :create => {:title => "新建"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ##############################帐目盘点登记表#############################################
    subject_title = "帐目盘点登记表"
    subject = "Journal"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'journals_path',
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
      :default_action => 'orgs_path',
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
      :default_action => 'users_path',
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
      :default_action => 'roles_path',
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
      :default_action => 'customers_path',
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
      :default_action => 'vips_path',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    #################################客户分级################################################
    subject_title = "客户分级"
    subject = "ImportedCustomer"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'imported_customers_path',
      :subject => subject,
      :function => {
      :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
      :create => {:title => "新建"}
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
      :default_action => 'banks_path',
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
      :default_action => 'transit_companies_path',
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
      :default_action => 'config_cashes_path',
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
      :default_action => 'config_transits_path',
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
      :default_action => 'il_configs_path',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)

    ####################################理赔管理#########################################################
    group_name = "理赔管理"
    #################################理赔管理################################################
    subject_title = "理赔"
    subject = "GoodsException"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'goods_exceptions_path',
      :function => {
      #查看相关运单,其他机构发往当前用户机构的运单
      :read => {:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"},
      :create => {:title => "新建"},
      :show_authorize => {:title => "授权核销",:conditions =>"{:state => 'submited',:org_id => user.current_ability_org_ids  }"},
      :show_claim => {:title => "理赔",:conditions =>"{:state => 'authorized',:org_id => user.current_ability_org_ids }"},
      :show_identify => {:title => "责任鉴定",:conditions =>"{:state => 'compensated',:org_id => user.current_ability_org_ids }"},
      :print => {:title => "打印"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    #################################送货管理################################################
    group_name = "送货管理"
    subject_title = "送货员信息"
    subject = "Sender"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'senders_path',
      :function => {
      #查看相关运单,其他机构发往当前用户机构的运单
      :read => {:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"},
      :create => {:title => "新建"},
      :update => {:title => "修改",:conditions =>"{:org_id => user.current_ability_org_ids }"},
      :destroy => {:title => "删除",:conditions =>"{:org_id => user.current_ability_org_ids }"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ###############################送货登记##################################################
    subject_title = "送货登记"
    subject = "SendList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'send_lists_path',
      :function => {
      #查看相关运单,其他机构发往当前用户机构的运单
      :read => {:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"},
      :create => {:title => "新建"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ###############################交票核销##################################################
    subject_title = "交票核销"
    subject = "SendListPost"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'new_send_list_post_path',
      :function => {
      :read => {:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"},
      :create => {:title => "新建"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
    ###############################未交票统计##################################################
    subject_title = "未交票统计"
    subject = "SendListBack"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'new_send_list_back_path',
      :function => {
      :read => {:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"},
      :create => {:title => "新建"},
      :export => {:title => "导出"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
  end
end
