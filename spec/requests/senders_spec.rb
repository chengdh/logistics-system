#coding: utf-8
#coding: utf-8
require 'spec_helper'

describe "Senders" do
  describe "GET /senders" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get senders_path
      response.status.should be(200)
    end
  end
end
