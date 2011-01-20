#coding: utf-8
require 'ruby-pinyin/pinyin'
class Org < ActiveRecord::Base
  validates_presence_of :name
  acts_as_tree :order => :name
  before_save :gen_py

  private
  def gen_py
    py = PinYin.instance
    self.py = py.to_pinyin_abbr(self.name)
  end
end
