#coding: utf-8
class SystemFunctionGroup < ActiveRecord::Base
  has_many :system_functions 
  default_scope :include => :system_functions
end
