class UserOrg < ActiveRecord::Base
  belongs_to :user,:touch => true
  belongs_to :org,:include => [:parent,:children]
end
