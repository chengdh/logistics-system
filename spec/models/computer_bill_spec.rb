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
  it "票据初始状态应为'已开票'" do 
    @computer_bill.should be_billed
  end
  it "票据进行装车后,状态应变为'已装车'" do
    @computer_bill.standard_process
    @computer_bill.should be_loaded
  end
  it "票据进行发车操作后,其状态应被修改为'已发出'" do
    @computer_bill.standard_process
    @computer_bill.standard_process
    @computer_bill.should be_shipped
  end
  it "票据进行到货确认操作后,其状态应被修改为'已到货'" do
    @computer_bill.standard_process
    @computer_bill.standard_process
    @computer_bill.standard_process
    @computer_bill.should be_reached
  end
  it "在已开票及已装车状态下进行退货操作,运单状态应被修改为'已退货状态'" do
    @computer_bill.return
    @computer_bill.should be_returned
  end
  it "在已货物已发出或货物已到达状态下进行退货操作,则运单状态应被修改为'已退货状态',并会生成一张退货运单" do
    @computer_bill.standard_process
    @computer_bill.standard_process
    @computer_bill.standard_process
    @computer_bill.return
    @computer_bill.should be_returned
    @computer_bill.return_bill.should_not be_blank
  end
end
