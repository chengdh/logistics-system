require 'spec_helper'

describe "branches/new.html.erb" do
  before(:each) do
    assign(:branch, stub_model(Branch).as_new_record)
  end

  it "renders new branch form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => branches_path, :method => "post" do
    end
  end
end
