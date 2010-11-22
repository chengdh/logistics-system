require 'spec_helper'

describe "hand_transit_bills/new.html.erb" do
  before(:each) do
    assign(:hand_transit_bill, stub_model(HandTransitBill).as_new_record)
  end

  it "renders new hand_transit_bill form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => hand_transit_bills_path, :method => "post" do
    end
  end
end
