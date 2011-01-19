require 'spec_helper'

describe "change_insured_rate_from_carrying_bills/index.html.erb" do
  before(:each) do
    assign(:change_insured_rate_from_carrying_bills, [
      stub_model(ChangeInsuredRateFromCarryingBill,
        :insured_rate => "9.99"
      ),
      stub_model(ChangeInsuredRateFromCarryingBill,
        :insured_rate => "9.99"
      )
    ])
  end

  it "renders a list of change_insured_rate_from_carrying_bills" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
