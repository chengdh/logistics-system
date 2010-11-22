require 'spec_helper'

describe "transit_bills/show.html.erb" do
  before(:each) do
    @transit_bill = assign(:transit_bill, stub_model(TransitBill))
  end

  it "renders attributes in <p>" do
    render
  end
end
