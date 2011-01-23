class Sender < ActiveRecord::Base
  belongs_to :org
  validates_presence_of :name
end
