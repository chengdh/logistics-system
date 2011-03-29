#coding: utf-8 
#系统功能类 
class SystemFunction < ActiveRecord::Base 
  belongs_to :system_function_group
  has_many :system_function_operates
  #根据传入的hash生成system_function,在rake task中调用
  def self.create_by_hash(attrs ={})
    group = SystemFunctionGroup.find_or_create_by_name(attrs[:group_name])
    sf = group.system_functions.create(:subject_title => attrs[:subject_title],:default_action => attrs[:default_action])
    attrs[:function].each do |key,value|
      system_function = sf.system_function_operates.create(
                                              :name => value[:title],
                                              :function_obj => 
      {
        :subject => attrs[:subject],
        :action => key,
        :conditions => value[:conditions]})
    end
  end
end
