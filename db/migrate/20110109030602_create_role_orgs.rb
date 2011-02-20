#coding: utf-8
#coding: utf-8
class CreateRoleOrgs < ActiveRecord::Migration
  def self.up
    create_table :role_orgs do |t|
      t.references :role,:null => false
      t.references :org,:null => false
      t.boolean :is_select,:default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :role_orgs
  end
end
