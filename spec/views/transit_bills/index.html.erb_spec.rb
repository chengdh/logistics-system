require 'spec_helper'

describe "transit_bills/index.html.erb" do
  before(:each) do
    assign(:transit_bills, [
      stub_model(TransitBill),
      stub_model(TransitBill)
    ])
  end

  it "renders a list of transit_bills" do
    render
  end
end
