require 'spec_helper'

describe "hand_bills/show.html.erb" do
  before(:each) do
    @hand_bill = assign(:hand_bill, stub_model(HandBill))
  end

  it "renders attributes in <p>" do
    render
  end
end
