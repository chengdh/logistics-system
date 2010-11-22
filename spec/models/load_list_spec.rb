#coding: utf-8
require 'spec_helper'

describe LoadList do
  before(:each) do
    @load_list = Factory.build(:load_list)
  end
  it "应能正确保存装车清单" do
    @load_list.save!
  end
  it "因必须录入发货地和到货地字段" do
    @load_list.from_org = nil
    @load_list.to_org = nil
    @load_list.should_not be_valid
  end
end
