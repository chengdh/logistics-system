require 'spec_helper'

describe "hand_bills/index.html.erb" do
  before(:each) do
    assign(:hand_bills, [
      stub_model(HandBill),
      stub_model(HandBill)
    ])
  end

  it "renders a list of hand_bills" do
    render
  end
end
