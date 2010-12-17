class Bank < ActiveRecord::Base
  validates :name,:code,:presence => true
  validates :code,:uniqueness => true
end
