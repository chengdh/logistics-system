require 'spec_helper'

describe ComputerBillsController do

  def mock_computer_bill(stubs={})
    (@mock_computer_bill ||= mock_model(ComputerBill).as_null_object).tap do |computer_bill|
      computer_bill.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all computer_bills as @computer_bills" do
      ComputerBill.stub(:all) { [mock_computer_bill] }
      get :index
      assigns(:computer_bills).should eq([mock_computer_bill])
    end
  end

  describe "GET show" do
    it "assigns the requested computer_bill as @computer_bill" do
      ComputerBill.stub(:find).with("37") { mock_computer_bill }
      get :show, :id => "37"
      assigns(:computer_bill).should be(mock_computer_bill)
    end
  end

  describe "GET new" do
    it "assigns a new computer_bill as @computer_bill" do
      ComputerBill.stub(:new) { mock_computer_bill }
      get :new
      assigns(:computer_bill).should be(mock_computer_bill)
    end
  end

  describe "GET edit" do
    it "assigns the requested computer_bill as @computer_bill" do
      ComputerBill.stub(:find).with("37") { mock_computer_bill }
      get :edit, :id => "37"
      assigns(:computer_bill).should be(mock_computer_bill)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created computer_bill as @computer_bill" do
        ComputerBill.stub(:new).with({'these' => 'params'}) { mock_computer_bill(:save => true) }
        post :create, :computer_bill => {'these' => 'params'}
        assigns(:computer_bill).should be(mock_computer_bill)
      end

      it "redirects to the created computer_bill" do
        ComputerBill.stub(:new) { mock_computer_bill(:save => true) }
        post :create, :computer_bill => {}
        response.should redirect_to(computer_bill_url(mock_computer_bill))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved computer_bill as @computer_bill" do
        ComputerBill.stub(:new).with({'these' => 'params'}) { mock_computer_bill(:save => false) }
        post :create, :computer_bill => {'these' => 'params'}
        assigns(:computer_bill).should be(mock_computer_bill)
      end

      it "re-renders the 'new' template" do
        ComputerBill.stub(:new) { mock_computer_bill(:save => false) }
        post :create, :computer_bill => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested computer_bill" do
        ComputerBill.should_receive(:find).with("37") { mock_computer_bill }
        mock_computer_bill.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :computer_bill => {'these' => 'params'}
      end

      it "assigns the requested computer_bill as @computer_bill" do
        ComputerBill.stub(:find) { mock_computer_bill(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:computer_bill).should be(mock_computer_bill)
      end

      it "redirects to the computer_bill" do
        ComputerBill.stub(:find) { mock_computer_bill(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(computer_bill_url(mock_computer_bill))
      end
    end

    describe "with invalid params" do
      it "assigns the computer_bill as @computer_bill" do
        ComputerBill.stub(:find) { mock_computer_bill(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:computer_bill).should be(mock_computer_bill)
      end

      it "re-renders the 'edit' template" do
        ComputerBill.stub(:find) { mock_computer_bill(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested computer_bill" do
      ComputerBill.should_receive(:find).with("37") { mock_computer_bill }
      mock_computer_bill.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the computer_bills list" do
      ComputerBill.stub(:find) { mock_computer_bill }
      delete :destroy, :id => "1"
      response.should redirect_to(computer_bills_url)
    end
  end

end
