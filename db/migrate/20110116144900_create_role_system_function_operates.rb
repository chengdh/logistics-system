#coding: utf-8
#coding: utf-8
#角色操作权限表
class CreateRoleSystemFunctionOperates < ActiveRecord::Migration
  def self.up
    create_table :role_system_function_operates do |t|
      t.references :role,:null => false
      t.references :system_function_operate,:null => false
      t.boolean :is_select,:default => false,:null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :role_system_function_operates
  end
end
