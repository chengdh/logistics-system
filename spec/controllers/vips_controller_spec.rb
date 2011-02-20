#coding: utf-8
#coding: utf-8
require 'spec_helper'

describe VipsController do

  def mock_vip(stubs={})
    (@mock_vip ||= mock_model(Vip).as_null_object).tap do |vip|
      vip.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all vips as @vips" do
      Vip.stub(:all) { [mock_vip] }
      get :index
      assigns(:vips).should eq([mock_vip])
    end
  end

  describe "GET show" do
    it "assigns the requested vip as @vip" do
      Vip.stub(:find).with("37") { mock_vip }
      get :show, :id => "37"
      assigns(:vip).should be(mock_vip)
    end
  end

  describe "GET new" do
    it "assigns a new vip as @vip" do
      Vip.stub(:new) { mock_vip }
      get :new
      assigns(:vip).should be(mock_vip)
    end
  end

  describe "GET edit" do
    it "assigns the requested vip as @vip" do
      Vip.stub(:find).with("37") { mock_vip }
      get :edit, :id => "37"
      assigns(:vip).should be(mock_vip)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created vip as @vip" do
        Vip.stub(:new).with({'these' => 'params'}) { mock_vip(:save => true) }
        post :create, :vip => {'these' => 'params'}
        assigns(:vip).should be(mock_vip)
      end

      it "redirects to the created vip" do
        Vip.stub(:new) { mock_vip(:save => true) }
        post :create, :vip => {}
        response.should redirect_to(vip_url(mock_vip))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved vip as @vip" do
        Vip.stub(:new).with({'these' => 'params'}) { mock_vip(:save => false) }
        post :create, :vip => {'these' => 'params'}
        assigns(:vip).should be(mock_vip)
      end

      it "re-renders the 'new' template" do
        Vip.stub(:new) { mock_vip(:save => false) }
        post :create, :vip => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested vip" do
        Vip.should_receive(:find).with("37") { mock_vip }
        mock_vip.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :vip => {'these' => 'params'}
      end

      it "assigns the requested vip as @vip" do
        Vip.stub(:find) { mock_vip(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:vip).should be(mock_vip)
      end

      it "redirects to the vip" do
        Vip.stub(:find) { mock_vip(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(vip_url(mock_vip))
      end
    end

    describe "with invalid params" do
      it "assigns the vip as @vip" do
        Vip.stub(:find) { mock_vip(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:vip).should be(mock_vip)
      end

      it "re-renders the 'edit' template" do
        Vip.stub(:find) { mock_vip(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested vip" do
      Vip.should_receive(:find).with("37") { mock_vip }
      mock_vip.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the vips list" do
      Vip.stub(:find) { mock_vip }
      delete :destroy, :id => "1"
      response.should redirect_to(vips_url)
    end
  end

end
