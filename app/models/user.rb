class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable,
         :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:username,:is_admin,:default_role_id,:default_org_id,:is_active,:user_roles_attributes

  validates_presence_of :username
  validates :password,:confirmation => true
  has_many :user_roles
  has_many :roles,:through => :user_roles
  belongs_to :default_org,:class_name => "Org"
  belongs_to :default_role,:class_name => "Role"
  accepts_nested_attributes_for :user_roles,:allow_destroy => true

  def self.new_with_roles(attrs= {})
    ret = User.new(attrs)
    ret.all_user_roles!
    ret
  end
  #显示所有部门,包括当前角色具备与不具备的部门
  def all_user_roles!
    Role.where(:is_active => true).each do |role|
      self.user_roles.build(:role => role) unless self.user_roles.detect { |the_user_role| the_user_role.role.id == role.id } 
    end
    self.user_roles
  end
end
