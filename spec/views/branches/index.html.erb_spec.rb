require 'spec_helper'

describe "branches/index.html.erb" do
  before(:each) do
    assign(:branches, [
      stub_model(Branch),
      stub_model(Branch)
    ])
  end

  it "renders a list of branches" do
    render
  end
end
