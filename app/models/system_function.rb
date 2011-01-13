#coding: utf-8 
#系统功能类 
class SystemFunction < ActiveRecord::Base 
  serialize :function_obj
  belongs_to :system_function_group
  #根据传入的hash生成system_function,在rake task中调用
  def self.create_by_hash(attrs ={})
    group = SystemFunctionGroup.find_or_create_by_name(attrs[:group_name])
    attrs[:function].each do |key,value|
      system_function = SystemFunction.create(:system_function_group => group,
                                              :subject_title => attrs[:subject_title],
                                              :action_title => value[:title],
                                              :function_obj => 
      {
        :subject => attrs[:subject],
        :action => key,
        :conditions => value[:conditions]})

    end
  end
end
