#coding: utf-8
class Org < ActiveRecord::Base
  validates_presence_of :name
  acts_as_tree :order => :name
end
