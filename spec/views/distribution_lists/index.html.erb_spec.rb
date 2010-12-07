require 'spec_helper'

describe "distribution_lists/index.html.erb" do
  before(:each) do
    assign(:distribution_lists, [
      stub_model(DistributionList,
        :user => nil,
        :note => "MyText"
      ),
      stub_model(DistributionList,
        :user => nil,
        :note => "MyText"
      )
    ])
  end

  it "renders a list of distribution_lists" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
