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
  #得到当前用户可访问的部门
  #如果是最末级机构,只可访问自己的数据,如果是上级机构,则可访问所有下级机构数据
  #FIXME 注意,当前只支持二级机构
  def current_ability_orgs
    ret = [self.default_org] + self.default_org.children
  end
def current_ability_org_ids
    self.current_ability_orgs.map {|org| org.id}
  end

end
