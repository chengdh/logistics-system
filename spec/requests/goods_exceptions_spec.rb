require 'spec_helper'

describe "GoodsExceptions" do
  describe "GET /goods_exceptions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get goods_exceptions_path
      response.status.should be(200)
    end
  end
end
