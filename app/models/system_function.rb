#coding: utf-8
#系统功能类
class SystemFunction < ActiveRecord::Base
  belongs_to :sytem_function_group
  serialize :function_obj,AbilityObj
end
