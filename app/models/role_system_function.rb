class  RoleSystemFunction < ActiveRecord::Base
  belongs_to :role
  belongs_to :system_function
end
