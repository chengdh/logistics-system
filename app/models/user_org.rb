class UserOrg < ActiveRecord::Base
  belongs_to :user
  belongs_to :org,:include => [:parent,:children]
end
