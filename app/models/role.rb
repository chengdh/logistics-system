class Role < ActiveRecord::Base
  validates_presence_of :name
  has_many :user_roles
  has_many :users,:through => :user_roles,:uniq => true
  has_many :role_system_functions
  has_many :system_functions,:through => :role_system_functions,:uniq => true
  has_many :role_orgs
  has_many :orgs,:through => :role_orgs,:uniq => true
  accepts_nested_attributes_for :role_system_functions,:allow_destroy => true
  accepts_nested_attributes_for :role_orgs,:allow_destroy => true

  #显示所有系统功能,包括当前角色具备的功能
  def all_role_system_functions!
    SystemFunction.where(:is_active => true).order("system_function_group_id").each do |sf|
      self.role_system_functions.build(:system_function => sf) unless self.role_system_functions.detect { |the_rsf| the_rsf.system_function.id == sf.id }
    end
    self.role_system_functions
  end
  #显示所有部门,包括当前角色具备与不具备的部门
  def all_role_orgs!
    Org.where(:is_active => true).order("type").each do |org|
      self.role_orgs.build(:org => org) unless self.role_orgs.detect { |the_role_org| the_role_org.org.id == org.id } 
    end
    self.role_orgs
  end

  def self.new_with_default(attributes = nil)
    role = Role.new(attributes)
    role.all_role_system_functions!
    role.all_role_orgs!
    role
  end
end
