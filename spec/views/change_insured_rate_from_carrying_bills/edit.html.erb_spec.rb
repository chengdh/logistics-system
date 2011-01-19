require 'spec_helper'

describe "change_insured_rate_from_carrying_bills/edit.html.erb" do
  before(:each) do
    @change_insured_rate_from_carrying_bill = assign(:change_insured_rate_from_carrying_bill, stub_model(ChangeInsuredRateFromCarryingBill,
      :insured_rate => "9.99"
    ))
  end

  it "renders the edit change_insured_rate_from_carrying_bill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => change_insured_rate_from_carrying_bill_path(@change_insured_rate_from_carrying_bill), :method => "post" do
      assert_select "input#change_insured_rate_from_carrying_bill_insured_rate", :name => "change_insured_rate_from_carrying_bill[insured_rate]"
    end
  end
end
