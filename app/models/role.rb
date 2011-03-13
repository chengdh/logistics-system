#coding: utf-8
class Role < ActiveRecord::Base
  validates_presence_of :name
  has_many :user_roles
  has_many :users,:through => :user_roles,:uniq => true
  has_many :role_system_function_operates
  has_many :system_function_operates,:through => :role_system_function_operates,:uniq => true
  accepts_nested_attributes_for :role_system_function_operates,:allow_destroy => true

  validates :name,:presence => true,:uniqueness => true

  #显示所有系统功能,包括当前角色具备的功能
  def all_role_system_function_operates!
    SystemFunctionOperate.where(:is_active => true).order("system_function_id").each do |sf_operate|
      self.role_system_function_operates.build(:system_function_operate => sf_operate) unless self.role_system_function_operates.detect { |the_rsf_op| the_rsf_op.system_function_operate.id == sf_operate.id }
    end
    #SystemFunctionOperate.where(:is_active => true).order("system_function_id").each do |sf_operate|
    #   self.system_function_operates << sf_operate unless self.system_function_operates.include?(sf_operate)
    # end
    self.role_system_function_operates
  end
  #根据系统功能得到对应的role_system_function_operate
  def single_function_operates(sf)
    @all_role_sfos ||= self.all_role_system_function_operates!
    @all_role_sfos.find_all {|ops| ops.system_function_operate.system_function.id == sf.id}
    #@all_role_sfos.search(:system_function_operate_system_function_id_eq => sf.id).all
  end

  def self.new_with_default(attributes = nil)
    role = Role.new(attributes)
    SystemFunctionOperate.where(:is_active => true).order("system_function_id").each do |sf_operate|
      role.role_system_function_operates.build(:system_function_operate => sf_operate)
    end
    role
  end
  #得到被授权的system_function
  def system_functions
    @system_functions ||= self.system_function_operates.group_by(&:system_function).collect {|sf,sfo_array| sf}
  end
  #得到被授权的system_function_group
  def system_function_groups
    @system_function_groups ||= self.system_functions.group_by(&:system_function_group)
  end
  #重写to_s方法
  def to_s
    self.name
  end
end
