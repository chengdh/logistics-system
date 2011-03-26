#coding: utf-8
class SystemFunctionOperate < ActiveRecord::Base
  belongs_to :system_function
  serialize :function_obj
end
