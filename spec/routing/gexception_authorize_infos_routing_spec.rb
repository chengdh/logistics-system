require "spec_helper"

describe GexceptionAuthorizeInfosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/gexception_authorize_infos" }.should route_to(:controller => "gexception_authorize_infos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/gexception_authorize_infos/new" }.should route_to(:controller => "gexception_authorize_infos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/gexception_authorize_infos/1" }.should route_to(:controller => "gexception_authorize_infos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/gexception_authorize_infos/1/edit" }.should route_to(:controller => "gexception_authorize_infos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/gexception_authorize_infos" }.should route_to(:controller => "gexception_authorize_infos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/gexception_authorize_infos/1" }.should route_to(:controller => "gexception_authorize_infos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/gexception_authorize_infos/1" }.should route_to(:controller => "gexception_authorize_infos", :action => "destroy", :id => "1")
    end

  end
end
