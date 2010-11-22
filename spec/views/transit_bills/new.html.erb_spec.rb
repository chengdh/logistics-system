require 'spec_helper'

describe "transit_bills/new.html.erb" do
  before(:each) do
    assign(:transit_bill, stub_model(TransitBill).as_new_record)
  end

  it "renders new transit_bill form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => transit_bills_path, :method => "post" do
    end
  end
end
