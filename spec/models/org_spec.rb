#coding: utf-8
require 'spec_helper'

describe Org do
  before(:each) do 
    @attr = Factory.attributes_for(:org)
  end
  it "应能够成功新建机构信息" do 
    Org.create!(@attr)
  end
  it "必须录入机构名称才能保存" do 
    no_name_org = Org.new(@attr.merge(:name => ""))
    no_name_org.should_not be_valid
  end
end
