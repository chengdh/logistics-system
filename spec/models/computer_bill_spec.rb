#coding: utf-8
require 'spec_helper'

describe ComputerBill do
  before(:each) do
    @computer_bill = Factory.build(:computer_bill)
  end
  it "应能够成功创建一张机打票据" do 
    @computer_bill.save!
  end
  it "机打票保存后应自动产生票据编号和货号" do
    @computer_bill.save!
    @computer_bill.bill_no.should_not be_blank
    @computer_bill.goods_no.should_not be_blank
  end
  it "机打票必须录入票据日期字段" do
    @computer_bill.bill_date = nil
    @computer_bill.should_not be_valid
  end
  it "机打票必须录入发货地和到货地" do
    @computer_bill.from_org = nil
    @computer_bill.to_org = nil
    @computer_bill.should_not be_valid
  end


end
