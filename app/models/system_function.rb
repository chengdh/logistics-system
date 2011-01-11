#coding: utf-8
#系统功能类
class SystemFunction < ActiveRecord::Base
  serialize :function_obj
  belongs_to :system_function_group
end
