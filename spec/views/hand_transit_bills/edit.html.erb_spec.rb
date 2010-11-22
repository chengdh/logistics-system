require 'spec_helper'

describe "hand_transit_bills/edit.html.erb" do
  before(:each) do
    @hand_transit_bill = assign(:hand_transit_bill, stub_model(HandTransitBill,
      :new_record? => false
    ))
  end

  it "renders the edit hand_transit_bill form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => hand_transit_bill_path(@hand_transit_bill), :method => "post" do
    end
  end
end
