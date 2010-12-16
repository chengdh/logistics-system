class Customer < ActiveRecord::Base
  belongs_to :org
  belongs_to :bank
end
