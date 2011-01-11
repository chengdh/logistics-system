class CreateRoleSystemFunctionJoinTable < ActiveRecord::Migration
  def self.up
    create_table :role_system_functions do |t|
      t.references :role,:system_function
      t.boolean :is_select,:default => false,:null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :role_system_functions
  end
end
