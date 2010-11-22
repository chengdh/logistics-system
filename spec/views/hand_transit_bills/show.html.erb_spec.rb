require 'spec_helper'

describe "hand_transit_bills/show.html.erb" do
  before(:each) do
    @hand_transit_bill = assign(:hand_transit_bill, stub_model(HandTransitBill))
  end

  it "renders attributes in <p>" do
    render
  end
end
