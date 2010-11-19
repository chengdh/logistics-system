require 'spec_helper'

describe "return_bills/edit.html.erb" do
  before(:each) do
    @return_bill = assign(:return_bill, stub_model(ReturnBill,
      :new_record? => false
    ))
  end

  it "renders the edit return_bill form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => return_bill_path(@return_bill), :method => "post" do
    end
  end
end
