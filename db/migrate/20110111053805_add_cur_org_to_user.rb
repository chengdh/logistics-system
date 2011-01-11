class AddCurOrgToUser < ActiveRecord::Migration
  def self.up
    change_column :users,:email,:string,:null => true
    #添加一个默认用户
    #User.create(:username => "admin",:password => "admin",:is_admin => true)
  end

  def self.down
    change_column :users,:email,:string,:null => false
  end
end
