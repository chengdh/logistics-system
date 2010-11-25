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
  it "装车单保存后,其状态应为'已装车'" do
    @load_list.save!
    @load_list.should be_loaded
  end
  it "装车单发出后,其状态应为'已发出'" do
    @load_list.save!
    @load_list.process
    @load_list.should be_shipped
  end
  it "装车单到货确认后,其状态应变为'已到货'" do
    @load_list.save!
    @load_list.process
    @load_list.process
    @load_list.should be_reached

  end

end
