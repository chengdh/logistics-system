#coding: utf-8
#coding: utf-8
require 'spec_helper'

describe TransitCompaniesController do

  def mock_transit_company(stubs={})
    (@mock_transit_company ||= mock_model(TransitCompany).as_null_object).tap do |transit_company|
      transit_company.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all transit_companies as @transit_companies" do
      TransitCompany.stub(:all) { [mock_transit_company] }
      get :index
      assigns(:transit_companies).should eq([mock_transit_company])
    end
  end

  describe "GET show" do
    it "assigns the requested transit_company as @transit_company" do
      TransitCompany.stub(:find).with("37") { mock_transit_company }
      get :show, :id => "37"
      assigns(:transit_company).should be(mock_transit_company)
    end
  end

  describe "GET new" do
    it "assigns a new transit_company as @transit_company" do
      TransitCompany.stub(:new) { mock_transit_company }
      get :new
      assigns(:transit_company).should be(mock_transit_company)
    end
  end

  describe "GET edit" do
    it "assigns the requested transit_company as @transit_company" do
      TransitCompany.stub(:find).with("37") { mock_transit_company }
      get :edit, :id => "37"
      assigns(:transit_company).should be(mock_transit_company)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created transit_company as @transit_company" do
        TransitCompany.stub(:new).with({'these' => 'params'}) { mock_transit_company(:save => true) }
        post :create, :transit_company => {'these' => 'params'}
        assigns(:transit_company).should be(mock_transit_company)
      end

      it "redirects to the created transit_company" do
        TransitCompany.stub(:new) { mock_transit_company(:save => true) }
        post :create, :transit_company => {}
        response.should redirect_to(transit_company_url(mock_transit_company))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved transit_company as @transit_company" do
        TransitCompany.stub(:new).with({'these' => 'params'}) { mock_transit_company(:save => false) }
        post :create, :transit_company => {'these' => 'params'}
        assigns(:transit_company).should be(mock_transit_company)
      end

      it "re-renders the 'new' template" do
        TransitCompany.stub(:new) { mock_transit_company(:save => false) }
        post :create, :transit_company => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested transit_company" do
        TransitCompany.should_receive(:find).with("37") { mock_transit_company }
        mock_transit_company.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :transit_company => {'these' => 'params'}
      end

      it "assigns the requested transit_company as @transit_company" do
        TransitCompany.stub(:find) { mock_transit_company(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:transit_company).should be(mock_transit_company)
      end

      it "redirects to the transit_company" do
        TransitCompany.stub(:find) { mock_transit_company(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(transit_company_url(mock_transit_company))
      end
    end

    describe "with invalid params" do
      it "assigns the transit_company as @transit_company" do
        TransitCompany.stub(:find) { mock_transit_company(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:transit_company).should be(mock_transit_company)
      end

      it "re-renders the 'edit' template" do
        TransitCompany.stub(:find) { mock_transit_company(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested transit_company" do
      TransitCompany.should_receive(:find).with("37") { mock_transit_company }
      mock_transit_company.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the transit_companies list" do
      TransitCompany.stub(:find) { mock_transit_company }
      delete :destroy, :id => "1"
      response.should redirect_to(transit_companies_url)
    end
  end

end
