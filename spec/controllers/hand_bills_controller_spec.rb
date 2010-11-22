require 'spec_helper'

describe HandBillsController do

  def mock_hand_bill(stubs={})
    (@mock_hand_bill ||= mock_model(HandBill).as_null_object).tap do |hand_bill|
      hand_bill.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all hand_bills as @hand_bills" do
      HandBill.stub(:all) { [mock_hand_bill] }
      get :index
      assigns(:hand_bills).should eq([mock_hand_bill])
    end
  end

  describe "GET show" do
    it "assigns the requested hand_bill as @hand_bill" do
      HandBill.stub(:find).with("37") { mock_hand_bill }
      get :show, :id => "37"
      assigns(:hand_bill).should be(mock_hand_bill)
    end
  end

  describe "GET new" do
    it "assigns a new hand_bill as @hand_bill" do
      HandBill.stub(:new) { mock_hand_bill }
      get :new
      assigns(:hand_bill).should be(mock_hand_bill)
    end
  end

  describe "GET edit" do
    it "assigns the requested hand_bill as @hand_bill" do
      HandBill.stub(:find).with("37") { mock_hand_bill }
      get :edit, :id => "37"
      assigns(:hand_bill).should be(mock_hand_bill)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created hand_bill as @hand_bill" do
        HandBill.stub(:new).with({'these' => 'params'}) { mock_hand_bill(:save => true) }
        post :create, :hand_bill => {'these' => 'params'}
        assigns(:hand_bill).should be(mock_hand_bill)
      end

      it "redirects to the created hand_bill" do
        HandBill.stub(:new) { mock_hand_bill(:save => true) }
        post :create, :hand_bill => {}
        response.should redirect_to(hand_bill_url(mock_hand_bill))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hand_bill as @hand_bill" do
        HandBill.stub(:new).with({'these' => 'params'}) { mock_hand_bill(:save => false) }
        post :create, :hand_bill => {'these' => 'params'}
        assigns(:hand_bill).should be(mock_hand_bill)
      end

      it "re-renders the 'new' template" do
        HandBill.stub(:new) { mock_hand_bill(:save => false) }
        post :create, :hand_bill => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested hand_bill" do
        HandBill.should_receive(:find).with("37") { mock_hand_bill }
        mock_hand_bill.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :hand_bill => {'these' => 'params'}
      end

      it "assigns the requested hand_bill as @hand_bill" do
        HandBill.stub(:find) { mock_hand_bill(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:hand_bill).should be(mock_hand_bill)
      end

      it "redirects to the hand_bill" do
        HandBill.stub(:find) { mock_hand_bill(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(hand_bill_url(mock_hand_bill))
      end
    end

    describe "with invalid params" do
      it "assigns the hand_bill as @hand_bill" do
        HandBill.stub(:find) { mock_hand_bill(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:hand_bill).should be(mock_hand_bill)
      end

      it "re-renders the 'edit' template" do
        HandBill.stub(:find) { mock_hand_bill(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested hand_bill" do
      HandBill.should_receive(:find).with("37") { mock_hand_bill }
      mock_hand_bill.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the hand_bills list" do
      HandBill.stub(:find) { mock_hand_bill }
      delete :destroy, :id => "1"
      response.should redirect_to(hand_bills_url)
    end
  end

end
