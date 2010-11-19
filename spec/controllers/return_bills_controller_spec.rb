require 'spec_helper'

describe ReturnBillsController do

  def mock_return_bill(stubs={})
    (@mock_return_bill ||= mock_model(ReturnBill).as_null_object).tap do |return_bill|
      return_bill.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all return_bills as @return_bills" do
      ReturnBill.stub(:all) { [mock_return_bill] }
      get :index
      assigns(:return_bills).should eq([mock_return_bill])
    end
  end

  describe "GET show" do
    it "assigns the requested return_bill as @return_bill" do
      ReturnBill.stub(:find).with("37") { mock_return_bill }
      get :show, :id => "37"
      assigns(:return_bill).should be(mock_return_bill)
    end
  end

  describe "GET new" do
    it "assigns a new return_bill as @return_bill" do
      ReturnBill.stub(:new) { mock_return_bill }
      get :new
      assigns(:return_bill).should be(mock_return_bill)
    end
  end

  describe "GET edit" do
    it "assigns the requested return_bill as @return_bill" do
      ReturnBill.stub(:find).with("37") { mock_return_bill }
      get :edit, :id => "37"
      assigns(:return_bill).should be(mock_return_bill)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created return_bill as @return_bill" do
        ReturnBill.stub(:new).with({'these' => 'params'}) { mock_return_bill(:save => true) }
        post :create, :return_bill => {'these' => 'params'}
        assigns(:return_bill).should be(mock_return_bill)
      end

      it "redirects to the created return_bill" do
        ReturnBill.stub(:new) { mock_return_bill(:save => true) }
        post :create, :return_bill => {}
        response.should redirect_to(return_bill_url(mock_return_bill))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved return_bill as @return_bill" do
        ReturnBill.stub(:new).with({'these' => 'params'}) { mock_return_bill(:save => false) }
        post :create, :return_bill => {'these' => 'params'}
        assigns(:return_bill).should be(mock_return_bill)
      end

      it "re-renders the 'new' template" do
        ReturnBill.stub(:new) { mock_return_bill(:save => false) }
        post :create, :return_bill => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested return_bill" do
        ReturnBill.should_receive(:find).with("37") { mock_return_bill }
        mock_return_bill.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :return_bill => {'these' => 'params'}
      end

      it "assigns the requested return_bill as @return_bill" do
        ReturnBill.stub(:find) { mock_return_bill(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:return_bill).should be(mock_return_bill)
      end

      it "redirects to the return_bill" do
        ReturnBill.stub(:find) { mock_return_bill(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(return_bill_url(mock_return_bill))
      end
    end

    describe "with invalid params" do
      it "assigns the return_bill as @return_bill" do
        ReturnBill.stub(:find) { mock_return_bill(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:return_bill).should be(mock_return_bill)
      end

      it "re-renders the 'edit' template" do
        ReturnBill.stub(:find) { mock_return_bill(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested return_bill" do
      ReturnBill.should_receive(:find).with("37") { mock_return_bill }
      mock_return_bill.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the return_bills list" do
      ReturnBill.stub(:find) { mock_return_bill }
      delete :destroy, :id => "1"
      response.should redirect_to(return_bills_url)
    end
  end

end
