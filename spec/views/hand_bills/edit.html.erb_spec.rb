require 'spec_helper'

describe "hand_bills/edit.html.erb" do
  before(:each) do
    @hand_bill = assign(:hand_bill, stub_model(HandBill,
      :new_record? => false
    ))
  end

  it "renders the edit hand_bill form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => hand_bill_path(@hand_bill), :method => "post" do
    end
  end
end
