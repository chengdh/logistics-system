require 'spec_helper'

describe "return_bills/index.html.erb" do
  before(:each) do
    assign(:return_bills, [
      stub_model(ReturnBill),
      stub_model(ReturnBill)
    ])
  end

  it "renders a list of return_bills" do
    render
  end
end
