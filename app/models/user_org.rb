class UserOrg < ActiveRecord::Base
  belongs_to :user
  belongs_to :org
end
