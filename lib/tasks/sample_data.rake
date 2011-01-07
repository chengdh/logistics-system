#coding: utf-8 require 'faker'

namespace :db do
  desc "向数据库中添加示例数据"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
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
    魏县
    驻马店
    宁晋
    晋城
    双桥
    肉联厂
    磁县
    漯河
    临漳
    沙河
    涉县
    大名
    鸡泽
    侯马
    峰峰
    武安
    邯郸
    邢台].each_with_index do |name,index|
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

  end
end
