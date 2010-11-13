require 'spec_helper'

describe "departments/index.html.erb" do
  before(:each) do
    assign(:departments, [
      stub_model(Department),
      stub_model(Department)
    ])
  end

  it "renders a list of departments" do
    render
  end
end
