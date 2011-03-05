#coding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable,#:registerable,
         :rememberable, :trackable #:recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:username,:is_admin,:default_role_id,:default_org_id,:is_active,:user_roles_attributes,:user_orgs_attributes,:use_usb,:usb_pin

  validates_presence_of :username
  validates :password,:confirmation => true
  has_many :user_roles
  has_many :roles,:through => :user_roles
  has_many :user_orgs
  has_many :orgs,:through => :user_orgs
  belongs_to :default_org,:class_name => "Org"
  belongs_to :default_role,:class_name => "Role"
  accepts_nested_attributes_for :user_roles,:user_orgs,:allow_destroy => true
  #创建之前,写入usb_pin
  before_create :generate_usb_pin

  def self.new_with_roles(attrs= {})
    ret = User.new(attrs)
    ret.all_user_roles!
    ret.all_user_orgs!
    ret
  end
  #显示所有部门,包括当前角色具备与不具备的部门
  def all_user_roles!
    Role.where(:is_active => true).each do |role|
      self.user_roles.build(:role => role) unless self.user_roles.detect { |the_user_role| the_user_role.role.id == role.id } 
    end
    self.user_roles
  end
  #显示所有部门,包括当前角色具备与不具备的部门
  def all_user_orgs!
    Org.where(:is_active => true).order("name ASC").each do |org|
      self.user_orgs.build(:org => org) unless self.user_orgs.detect { |the_user_org| the_user_org.org.id == org.id } 
    end
    self.user_orgs.sort! {|x,y| x.org.id <=> y.org.id }
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
  def to_s
    self.username
  end
  private
  def generate_usb_pin
    self.usb_pin = UUID.generate(:compact)
  end
end
