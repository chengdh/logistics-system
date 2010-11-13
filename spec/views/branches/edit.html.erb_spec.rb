require 'spec_helper'

describe "branches/edit.html.erb" do
  before(:each) do
    @branch = assign(:branch, stub_model(Branch,
      :new_record? => false
    ))
  end

  it "renders the edit branch form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => branch_path(@branch), :method => "post" do
    end
  end
end
