require 'spec_helper'

describe HandTransitBillsController do

  def mock_hand_transit_bill(stubs={})
    (@mock_hand_transit_bill ||= mock_model(HandTransitBill).as_null_object).tap do |hand_transit_bill|
      hand_transit_bill.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all hand_transit_bills as @hand_transit_bills" do
      HandTransitBill.stub(:all) { [mock_hand_transit_bill] }
      get :index
      assigns(:hand_transit_bills).should eq([mock_hand_transit_bill])
    end
  end

  describe "GET show" do
    it "assigns the requested hand_transit_bill as @hand_transit_bill" do
      HandTransitBill.stub(:find).with("37") { mock_hand_transit_bill }
      get :show, :id => "37"
      assigns(:hand_transit_bill).should be(mock_hand_transit_bill)
    end
  end

  describe "GET new" do
    it "assigns a new hand_transit_bill as @hand_transit_bill" do
      HandTransitBill.stub(:new) { mock_hand_transit_bill }
      get :new
      assigns(:hand_transit_bill).should be(mock_hand_transit_bill)
    end
  end

  describe "GET edit" do
    it "assigns the requested hand_transit_bill as @hand_transit_bill" do
      HandTransitBill.stub(:find).with("37") { mock_hand_transit_bill }
      get :edit, :id => "37"
      assigns(:hand_transit_bill).should be(mock_hand_transit_bill)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created hand_transit_bill as @hand_transit_bill" do
        HandTransitBill.stub(:new).with({'these' => 'params'}) { mock_hand_transit_bill(:save => true) }
        post :create, :hand_transit_bill => {'these' => 'params'}
        assigns(:hand_transit_bill).should be(mock_hand_transit_bill)
      end

      it "redirects to the created hand_transit_bill" do
        HandTransitBill.stub(:new) { mock_hand_transit_bill(:save => true) }
        post :create, :hand_transit_bill => {}
        response.should redirect_to(hand_transit_bill_url(mock_hand_transit_bill))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hand_transit_bill as @hand_transit_bill" do
        HandTransitBill.stub(:new).with({'these' => 'params'}) { mock_hand_transit_bill(:save => false) }
        post :create, :hand_transit_bill => {'these' => 'params'}
        assigns(:hand_transit_bill).should be(mock_hand_transit_bill)
      end

      it "re-renders the 'new' template" do
        HandTransitBill.stub(:new) { mock_hand_transit_bill(:save => false) }
        post :create, :hand_transit_bill => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested hand_transit_bill" do
        HandTransitBill.should_receive(:find).with("37") { mock_hand_transit_bill }
        mock_hand_transit_bill.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :hand_transit_bill => {'these' => 'params'}
      end

      it "assigns the requested hand_transit_bill as @hand_transit_bill" do
        HandTransitBill.stub(:find) { mock_hand_transit_bill(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:hand_transit_bill).should be(mock_hand_transit_bill)
      end

      it "redirects to the hand_transit_bill" do
        HandTransitBill.stub(:find) { mock_hand_transit_bill(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(hand_transit_bill_url(mock_hand_transit_bill))
      end
    end

    describe "with invalid params" do
      it "assigns the hand_transit_bill as @hand_transit_bill" do
        HandTransitBill.stub(:find) { mock_hand_transit_bill(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:hand_transit_bill).should be(mock_hand_transit_bill)
      end

      it "re-renders the 'edit' template" do
        HandTransitBill.stub(:find) { mock_hand_transit_bill(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested hand_transit_bill" do
      HandTransitBill.should_receive(:find).with("37") { mock_hand_transit_bill }
      mock_hand_transit_bill.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the hand_transit_bills list" do
      HandTransitBill.stub(:find) { mock_hand_transit_bill }
      delete :destroy, :id => "1"
      response.should redirect_to(hand_transit_bills_url)
    end
  end

end
