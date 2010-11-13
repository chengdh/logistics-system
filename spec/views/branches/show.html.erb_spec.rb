require 'spec_helper'

describe "branches/show.html.erb" do
  before(:each) do
    @branch = assign(:branch, stub_model(Branch))
  end

  it "renders attributes in <p>" do
    render
  end
end
