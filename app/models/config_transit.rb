#coding: utf-8
class ConfigTransit < ActiveRecord::Base
  validates_presence_of :rate,:name
end
