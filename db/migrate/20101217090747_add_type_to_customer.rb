class AddTypeToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :type, :string,:limit => 20
  end

  def self.down
    remove_column :customers, :type
  end
end
