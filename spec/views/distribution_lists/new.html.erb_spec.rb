require 'spec_helper'

describe "distribution_lists/new.html.erb" do
  before(:each) do
    assign(:distribution_list, stub_model(DistributionList,
      :user => nil,
      :note => "MyText"
    ).as_new_record)
  end

  it "renders new distribution_list form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => distribution_lists_path, :method => "post" do
      assert_select "input#distribution_list_user", :name => "distribution_list[user]"
      assert_select "textarea#distribution_list_note", :name => "distribution_list[note]"
    end
  end
end
