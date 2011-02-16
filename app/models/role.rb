class Role < ActiveRecord::Base
  validates_presence_of :name
  has_many :user_roles
  has_many :users,:through => :user_roles,:uniq => true
  has_many :role_system_function_operates
  has_many :system_function_operates,:through => :role_system_function_operates,:uniq => true
  has_many :role_orgs
  has_many :orgs,:through => :role_orgs,:uniq => true
  accepts_nested_attributes_for :role_system_function_operates,:allow_destroy => true
  accepts_nested_attributes_for :role_orgs,:allow_destroy => true

  #显示所有系统功能,包括当前角色具备的功能
  def all_role_system_function_operates!
    SystemFunctionOperate.where(:is_active => true).order("system_function_id").each do |sf_operate|
      self.role_system_function_operates.build(:system_function_operate => sf_operate) unless self.role_system_function_operates.detect { |the_rsf_op| the_rsf_op.system_function_operate.id == sf_operate.id }
    end
    self.role_system_function_operates
  end
  #根据系统功能的到对应的role_system_function_operate
  def single_function_operates(sf)
    self.all_role_system_function_operates!.find_all {|ops| ops.system_function_operate.system_function.id == sf.id}
  end
  #显示所有部门,包括当前角色具备与不具备的部门
  def all_role_orgs!
    Org.where(:is_active => true).order("name ASC").each do |org|
      self.role_orgs.build(:org => org) unless self.role_orgs.detect { |the_role_org| the_role_org.org.id == org.id } 
    end
    self.role_orgs.sort! {|x,y| x.org.id <=> y.org.id }
  end

  def self.new_with_default(attributes = nil)
    role = Role.new(attributes)
    role.all_role_system_function_operates!
    role.all_role_orgs!
    role
  end
  #得到被授权的system_function
  def system_functions
    @system_functions ||= self.system_function_operates.group(:system_function_id).collect {|sfo| sfo.system_function}
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
