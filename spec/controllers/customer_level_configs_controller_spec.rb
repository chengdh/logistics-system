#coding: utf-8
#coding: utf-8
require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe CustomerLevelConfigsController do

  def mock_customer_level_config(stubs={})
    @mock_customer_level_config ||= mock_model(CustomerLevelConfig, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all customer_level_configs as @customer_level_configs" do
      CustomerLevelConfig.stub(:all) { [mock_customer_level_config] }
      get :index
      assigns(:customer_level_configs).should eq([mock_customer_level_config])
    end
  end

  describe "GET show" do
    it "assigns the requested customer_level_config as @customer_level_config" do
      CustomerLevelConfig.stub(:find).with("37") { mock_customer_level_config }
      get :show, :id => "37"
      assigns(:customer_level_config).should be(mock_customer_level_config)
    end
  end

  describe "GET new" do
    it "assigns a new customer_level_config as @customer_level_config" do
      CustomerLevelConfig.stub(:new) { mock_customer_level_config }
      get :new
      assigns(:customer_level_config).should be(mock_customer_level_config)
    end
  end

  describe "GET edit" do
    it "assigns the requested customer_level_config as @customer_level_config" do
      CustomerLevelConfig.stub(:find).with("37") { mock_customer_level_config }
      get :edit, :id => "37"
      assigns(:customer_level_config).should be(mock_customer_level_config)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created customer_level_config as @customer_level_config" do
        CustomerLevelConfig.stub(:new).with({'these' => 'params'}) { mock_customer_level_config(:save => true) }
        post :create, :customer_level_config => {'these' => 'params'}
        assigns(:customer_level_config).should be(mock_customer_level_config)
      end

      it "redirects to the created customer_level_config" do
        CustomerLevelConfig.stub(:new) { mock_customer_level_config(:save => true) }
        post :create, :customer_level_config => {}
        response.should redirect_to(customer_level_config_url(mock_customer_level_config))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved customer_level_config as @customer_level_config" do
        CustomerLevelConfig.stub(:new).with({'these' => 'params'}) { mock_customer_level_config(:save => false) }
        post :create, :customer_level_config => {'these' => 'params'}
        assigns(:customer_level_config).should be(mock_customer_level_config)
      end

      it "re-renders the 'new' template" do
        CustomerLevelConfig.stub(:new) { mock_customer_level_config(:save => false) }
        post :create, :customer_level_config => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested customer_level_config" do
        CustomerLevelConfig.stub(:find).with("37") { mock_customer_level_config }
        mock_customer_level_config.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :customer_level_config => {'these' => 'params'}
      end

      it "assigns the requested customer_level_config as @customer_level_config" do
        CustomerLevelConfig.stub(:find) { mock_customer_level_config(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:customer_level_config).should be(mock_customer_level_config)
      end

      it "redirects to the customer_level_config" do
        CustomerLevelConfig.stub(:find) { mock_customer_level_config(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(customer_level_config_url(mock_customer_level_config))
      end
    end

    describe "with invalid params" do
      it "assigns the customer_level_config as @customer_level_config" do
        CustomerLevelConfig.stub(:find) { mock_customer_level_config(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:customer_level_config).should be(mock_customer_level_config)
      end

      it "re-renders the 'edit' template" do
        CustomerLevelConfig.stub(:find) { mock_customer_level_config(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested customer_level_config" do
      CustomerLevelConfig.stub(:find).with("37") { mock_customer_level_config }
      mock_customer_level_config.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the customer_level_configs list" do
      CustomerLevelConfig.stub(:find) { mock_customer_level_config }
      delete :destroy, :id => "1"
      response.should redirect_to(customer_level_configs_url)
    end
  end

end
