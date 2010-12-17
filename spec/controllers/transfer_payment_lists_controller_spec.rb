require 'spec_helper'

describe TransferPaymentListsController do

  def mock_transfer_payment_list(stubs={})
    (@mock_transfer_payment_list ||= mock_model(TransferPaymentList).as_null_object).tap do |transfer_payment_list|
      transfer_payment_list.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all transfer_payment_lists as @transfer_payment_lists" do
      TransferPaymentList.stub(:all) { [mock_transfer_payment_list] }
      get :index
      assigns(:transfer_payment_lists).should eq([mock_transfer_payment_list])
    end
  end

  describe "GET show" do
    it "assigns the requested transfer_payment_list as @transfer_payment_list" do
      TransferPaymentList.stub(:find).with("37") { mock_transfer_payment_list }
      get :show, :id => "37"
      assigns(:transfer_payment_list).should be(mock_transfer_payment_list)
    end
  end

  describe "GET new" do
    it "assigns a new transfer_payment_list as @transfer_payment_list" do
      TransferPaymentList.stub(:new) { mock_transfer_payment_list }
      get :new
      assigns(:transfer_payment_list).should be(mock_transfer_payment_list)
    end
  end

  describe "GET edit" do
    it "assigns the requested transfer_payment_list as @transfer_payment_list" do
      TransferPaymentList.stub(:find).with("37") { mock_transfer_payment_list }
      get :edit, :id => "37"
      assigns(:transfer_payment_list).should be(mock_transfer_payment_list)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created transfer_payment_list as @transfer_payment_list" do
        TransferPaymentList.stub(:new).with({'these' => 'params'}) { mock_transfer_payment_list(:save => true) }
        post :create, :transfer_payment_list => {'these' => 'params'}
        assigns(:transfer_payment_list).should be(mock_transfer_payment_list)
      end

      it "redirects to the created transfer_payment_list" do
        TransferPaymentList.stub(:new) { mock_transfer_payment_list(:save => true) }
        post :create, :transfer_payment_list => {}
        response.should redirect_to(transfer_payment_list_url(mock_transfer_payment_list))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved transfer_payment_list as @transfer_payment_list" do
        TransferPaymentList.stub(:new).with({'these' => 'params'}) { mock_transfer_payment_list(:save => false) }
        post :create, :transfer_payment_list => {'these' => 'params'}
        assigns(:transfer_payment_list).should be(mock_transfer_payment_list)
      end

      it "re-renders the 'new' template" do
        TransferPaymentList.stub(:new) { mock_transfer_payment_list(:save => false) }
        post :create, :transfer_payment_list => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested transfer_payment_list" do
        TransferPaymentList.should_receive(:find).with("37") { mock_transfer_payment_list }
        mock_transfer_payment_list.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :transfer_payment_list => {'these' => 'params'}
      end

      it "assigns the requested transfer_payment_list as @transfer_payment_list" do
        TransferPaymentList.stub(:find) { mock_transfer_payment_list(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:transfer_payment_list).should be(mock_transfer_payment_list)
      end

      it "redirects to the transfer_payment_list" do
        TransferPaymentList.stub(:find) { mock_transfer_payment_list(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(transfer_payment_list_url(mock_transfer_payment_list))
      end
    end

    describe "with invalid params" do
      it "assigns the transfer_payment_list as @transfer_payment_list" do
        TransferPaymentList.stub(:find) { mock_transfer_payment_list(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:transfer_payment_list).should be(mock_transfer_payment_list)
      end

      it "re-renders the 'edit' template" do
        TransferPaymentList.stub(:find) { mock_transfer_payment_list(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested transfer_payment_list" do
      TransferPaymentList.should_receive(:find).with("37") { mock_transfer_payment_list }
      mock_transfer_payment_list.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the transfer_payment_lists list" do
      TransferPaymentList.stub(:find) { mock_transfer_payment_list }
      delete :destroy, :id => "1"
      response.should redirect_to(transfer_payment_lists_url)
    end
  end

end
