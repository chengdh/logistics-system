require 'spec_helper'

describe "departments/new.html.erb" do
  before(:each) do
    assign(:department, stub_model(Department).as_new_record)
  end

  it "renders new department form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => departments_path, :method => "post" do
    end
  end
end
