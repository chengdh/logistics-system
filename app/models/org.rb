#coding: utf-8
require 'ruby-pinyin/pinyin'
class Org < ActiveRecord::Base
  validates_presence_of :name
  acts_as_tree :order => :name
  before_save :gen_py

  #用于autocomplete列表显示
  def funky_method
    self.name
  end
  private
  def gen_py
    py = PinYin.instance
    self.py = py.to_pinyin_abbr(self.name)
  end
end
