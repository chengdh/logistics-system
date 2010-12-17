#coding: utf-8
require 'spec_helper'

describe CashPaymentList do
  before(:each) do
    @cash_payment_list = Factory.build(:cash_payment_list_with_bills)
  end
  it "应能够正确保存现金代收货款转账清单" do
    @cash_payment_list.save!
  end
end
