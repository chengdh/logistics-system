class RoleOrg < ActiveRecord::Base
  belongs_to :role
  belongs_to :org
end
