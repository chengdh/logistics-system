#coding: utf-8
class Customer < ActiveRecord::Base
  belongs_to :org
  belongs_to :bank
  #所对应的银行转账手续费设置
  belongs_to :config_transit
  validates_presence_of :name
end
