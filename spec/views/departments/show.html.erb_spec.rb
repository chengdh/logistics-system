require 'spec_helper'

describe "departments/show.html.erb" do
  before(:each) do
    @department = assign(:department, stub_model(Department))
  end

  it "renders attributes in <p>" do
    render
  end
end
