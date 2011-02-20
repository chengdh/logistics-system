#coding: utf-8
#coding: utf-8
require 'spec_helper'

describe "ConfigCashes" do
  describe "GET /config_cashes" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get config_cashes_path
      response.status.should be(200)
    end
  end
end
