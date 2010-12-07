require 'spec_helper'

describe "distribution_lists/edit.html.erb" do
  before(:each) do
    @distribution_list = assign(:distribution_list, stub_model(DistributionList,
      :new_record? => false,
      :user => nil,
      :note => "MyText"
    ))
  end

  it "renders the edit distribution_list form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => distribution_list_path(@distribution_list), :method => "post" do
      assert_select "input#distribution_list_user", :name => "distribution_list[user]"
      assert_select "textarea#distribution_list_note", :name => "distribution_list[note]"
    end
  end
end
