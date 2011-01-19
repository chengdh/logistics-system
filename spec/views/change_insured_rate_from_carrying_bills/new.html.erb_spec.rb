require 'spec_helper'

describe "change_insured_rate_from_carrying_bills/new.html.erb" do
  before(:each) do
    assign(:change_insured_rate_from_carrying_bill, stub_model(ChangeInsuredRateFromCarryingBill,
      :insured_rate => "9.99"
    ).as_new_record)
  end

  it "renders new change_insured_rate_from_carrying_bill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => change_insured_rate_from_carrying_bills_path, :method => "post" do
      assert_select "input#change_insured_rate_from_carrying_bill_insured_rate", :name => "change_insured_rate_from_carrying_bill[insured_rate]"
    end
  end
end
