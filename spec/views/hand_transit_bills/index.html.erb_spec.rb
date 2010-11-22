require 'spec_helper'

describe "hand_transit_bills/index.html.erb" do
  before(:each) do
    assign(:hand_transit_bills, [
      stub_model(HandTransitBill),
      stub_model(HandTransitBill)
    ])
  end

  it "renders a list of hand_transit_bills" do
    render
  end
end
