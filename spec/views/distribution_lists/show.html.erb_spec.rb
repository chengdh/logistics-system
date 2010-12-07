require 'spec_helper'

describe "distribution_lists/show.html.erb" do
  before(:each) do
    @distribution_list = assign(:distribution_list, stub_model(DistributionList,
      :user => nil,
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
