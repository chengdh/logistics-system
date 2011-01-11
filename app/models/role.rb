class Role < ActiveRecord::Base
  validates_presence_of :name
  has_many :user_roles
  has_many :users,:through => :user_roles
  has_many :role_system_functions
  has_many :system_functions,:through => :role_system_functions
  has_many :role_orgs
  has_many :orgs,:through => :role_orgs
  accepts_nested_attributes_for :role_system_functions,:role_orgs

  def self.new_with_default(attributes = nil)
    role = Role.new(attributes)
    SystemFunction.where(:is_active => true).order("system_function_group_id").each do |system_function|
      role.role_system_functions.build(:system_function => system_function)
    end
    Org.where(:is_active => true).order("type").each do |org|
      role.role_orgs.build(:org => org)
    end
    role
  end
end
