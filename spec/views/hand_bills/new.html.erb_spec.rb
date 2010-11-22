require 'spec_helper'

describe "hand_bills/new.html.erb" do
  before(:each) do
    assign(:hand_bill, stub_model(HandBill).as_new_record)
  end

  it "renders new hand_bill form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => hand_bills_path, :method => "post" do
    end
  end
end
