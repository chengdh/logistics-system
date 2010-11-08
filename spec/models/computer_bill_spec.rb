#coding: utf-8
require 'spec_helper'

describe ComputerBill do
  before(:each) do
    @attr = {}
  end
  it "应能够成功创建一张机打票据" do 
    ComputerBill.create!(@attr)
  end
end
