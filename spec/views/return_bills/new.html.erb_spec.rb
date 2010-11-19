require 'spec_helper'

describe "return_bills/new.html.erb" do
  before(:each) do
    assign(:return_bill, stub_model(ReturnBill).as_new_record)
  end

  it "renders new return_bill form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => return_bills_path, :method => "post" do
    end
  end
end
