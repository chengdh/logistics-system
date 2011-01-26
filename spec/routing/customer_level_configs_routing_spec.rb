require "spec_helper"

describe CustomerLevelConfigsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/customer_level_configs" }.should route_to(:controller => "customer_level_configs", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/customer_level_configs/new" }.should route_to(:controller => "customer_level_configs", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/customer_level_configs/1" }.should route_to(:controller => "customer_level_configs", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/customer_level_configs/1/edit" }.should route_to(:controller => "customer_level_configs", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/customer_level_configs" }.should route_to(:controller => "customer_level_configs", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/customer_level_configs/1" }.should route_to(:controller => "customer_level_configs", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/customer_level_configs/1" }.should route_to(:controller => "customer_level_configs", :action => "destroy", :id => "1")
    end

  end
end
