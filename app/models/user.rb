class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable,
         :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:username,:is_admin,:cur_org,:cur_role
  #当前角色和机构
  attr_accessor :cur_role,:cur_org

  validates_presence_of :username
  has_many :user_roles
  has_many :roles,:through => :user_roles
  belongs_to :cur_org,:foreign_key => "cur_org_id",:class_name => "Org"
  belongs_to :cur_role,:foreign_key => "cur_role_id",:class_name => "Role"
end
