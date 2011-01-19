require "spec_helper"

describe ChangeInsuredRateFromCarryingBillsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/change_insured_rate_from_carrying_bills" }.should route_to(:controller => "change_insured_rate_from_carrying_bills", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/change_insured_rate_from_carrying_bills/new" }.should route_to(:controller => "change_insured_rate_from_carrying_bills", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/change_insured_rate_from_carrying_bills/1" }.should route_to(:controller => "change_insured_rate_from_carrying_bills", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/change_insured_rate_from_carrying_bills/1/edit" }.should route_to(:controller => "change_insured_rate_from_carrying_bills", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/change_insured_rate_from_carrying_bills" }.should route_to(:controller => "change_insured_rate_from_carrying_bills", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/change_insured_rate_from_carrying_bills/1" }.should route_to(:controller => "change_insured_rate_from_carrying_bills", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/change_insured_rate_from_carrying_bills/1" }.should route_to(:controller => "change_insured_rate_from_carrying_bills", :action => "destroy", :id => "1")
    end

  end
end
