require 'spec_helper'

describe TransitBillsController do

  def mock_transit_bill(stubs={})
    (@mock_transit_bill ||= mock_model(TransitBill).as_null_object).tap do |transit_bill|
      transit_bill.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all transit_bills as @transit_bills" do
      TransitBill.stub(:all) { [mock_transit_bill] }
      get :index
      assigns(:transit_bills).should eq([mock_transit_bill])
    end
  end

  describe "GET show" do
    it "assigns the requested transit_bill as @transit_bill" do
      TransitBill.stub(:find).with("37") { mock_transit_bill }
      get :show, :id => "37"
      assigns(:transit_bill).should be(mock_transit_bill)
    end
  end

  describe "GET new" do
    it "assigns a new transit_bill as @transit_bill" do
      TransitBill.stub(:new) { mock_transit_bill }
      get :new
      assigns(:transit_bill).should be(mock_transit_bill)
    end
  end

  describe "GET edit" do
    it "assigns the requested transit_bill as @transit_bill" do
      TransitBill.stub(:find).with("37") { mock_transit_bill }
      get :edit, :id => "37"
      assigns(:transit_bill).should be(mock_transit_bill)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created transit_bill as @transit_bill" do
        TransitBill.stub(:new).with({'these' => 'params'}) { mock_transit_bill(:save => true) }
        post :create, :transit_bill => {'these' => 'params'}
        assigns(:transit_bill).should be(mock_transit_bill)
      end

      it "redirects to the created transit_bill" do
        TransitBill.stub(:new) { mock_transit_bill(:save => true) }
        post :create, :transit_bill => {}
        response.should redirect_to(transit_bill_url(mock_transit_bill))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved transit_bill as @transit_bill" do
        TransitBill.stub(:new).with({'these' => 'params'}) { mock_transit_bill(:save => false) }
        post :create, :transit_bill => {'these' => 'params'}
        assigns(:transit_bill).should be(mock_transit_bill)
      end

      it "re-renders the 'new' template" do
        TransitBill.stub(:new) { mock_transit_bill(:save => false) }
        post :create, :transit_bill => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested transit_bill" do
        TransitBill.should_receive(:find).with("37") { mock_transit_bill }
        mock_transit_bill.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :transit_bill => {'these' => 'params'}
      end

      it "assigns the requested transit_bill as @transit_bill" do
        TransitBill.stub(:find) { mock_transit_bill(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:transit_bill).should be(mock_transit_bill)
      end

      it "redirects to the transit_bill" do
        TransitBill.stub(:find) { mock_transit_bill(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(transit_bill_url(mock_transit_bill))
      end
    end

    describe "with invalid params" do
      it "assigns the transit_bill as @transit_bill" do
        TransitBill.stub(:find) { mock_transit_bill(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:transit_bill).should be(mock_transit_bill)
      end

      it "re-renders the 'edit' template" do
        TransitBill.stub(:find) { mock_transit_bill(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested transit_bill" do
      TransitBill.should_receive(:find).with("37") { mock_transit_bill }
      mock_transit_bill.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the transit_bills list" do
      TransitBill.stub(:find) { mock_transit_bill }
      delete :destroy, :id => "1"
      response.should redirect_to(transit_bills_url)
    end
  end

end
