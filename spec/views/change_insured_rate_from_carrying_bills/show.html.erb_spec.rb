require 'spec_helper'

describe "change_insured_rate_from_carrying_bills/show.html.erb" do
  before(:each) do
    @change_insured_rate_from_carrying_bill = assign(:change_insured_rate_from_carrying_bill, stub_model(ChangeInsuredRateFromCarryingBill,
      :insured_rate => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
  end
end
