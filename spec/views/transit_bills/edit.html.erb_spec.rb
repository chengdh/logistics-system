require 'spec_helper'

describe "transit_bills/edit.html.erb" do
  before(:each) do
    @transit_bill = assign(:transit_bill, stub_model(TransitBill,
      :new_record? => false
    ))
  end

  it "renders the edit transit_bill form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => transit_bill_path(@transit_bill), :method => "post" do
    end
  end
end
