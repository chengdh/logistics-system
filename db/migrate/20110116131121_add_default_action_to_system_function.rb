class AddDefaultActionToSystemFunction < ActiveRecord::Migration
  def self.up
    add_column :system_functions, :default_action, :string
  end

  def self.down
    remove_column :system_functions, :default_action
  end
end
