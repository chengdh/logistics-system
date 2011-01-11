#coding: utf-8
#初始化系统功能
class InitialSystemFunction < ActiveRecord::Migration
  def self.up
    group = SystemFunctionGroup.find_or_create_by_name("配送管理")
    subject_title = "机打运单管理"
    subject = "ComputerBill"
    {
      :read =>{:title => "查看"} ,
      :create => {:title => "新建"},
      :update =>{:title =>"修改"},
      :destroy => {:title => "删除",:conditions => {:state => [:loaded,:billed]}},
      :print => {:title => "打印"},
      :export => {:title => "导出"}
    }.each do |key,value|
      system_function = SystemFunction.create(:system_function_group => group,:subject_title => subject_title,:action_title => value[:title],:function_obj => {:subject => subject,key => value})
    end
  end

  def self.down
  end
end
