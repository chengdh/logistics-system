require 'spec_helper'

describe "return_bills/show.html.erb" do
  before(:each) do
    @return_bill = assign(:return_bill, stub_model(ReturnBill))
  end

  it "renders attributes in <p>" do
    render
  end
end
