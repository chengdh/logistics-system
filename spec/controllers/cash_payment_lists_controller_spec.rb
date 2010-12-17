require 'spec_helper'

describe CashPaymentListsController do

  def mock_cash_payment_list(stubs={})
    (@mock_cash_payment_list ||= mock_model(CashPaymentList).as_null_object).tap do |cash_payment_list|
      cash_payment_list.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all cash_payment_lists as @cash_payment_lists" do
      CashPaymentList.stub(:all) { [mock_cash_payment_list] }
      get :index
      assigns(:cash_payment_lists).should eq([mock_cash_payment_list])
    end
  end

  describe "GET show" do
    it "assigns the requested cash_payment_list as @cash_payment_list" do
      CashPaymentList.stub(:find).with("37") { mock_cash_payment_list }
      get :show, :id => "37"
      assigns(:cash_payment_list).should be(mock_cash_payment_list)
    end
  end

  describe "GET new" do
    it "assigns a new cash_payment_list as @cash_payment_list" do
      CashPaymentList.stub(:new) { mock_cash_payment_list }
      get :new
      assigns(:cash_payment_list).should be(mock_cash_payment_list)
    end
  end

  describe "GET edit" do
    it "assigns the requested cash_payment_list as @cash_payment_list" do
      CashPaymentList.stub(:find).with("37") { mock_cash_payment_list }
      get :edit, :id => "37"
      assigns(:cash_payment_list).should be(mock_cash_payment_list)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created cash_payment_list as @cash_payment_list" do
        CashPaymentList.stub(:new).with({'these' => 'params'}) { mock_cash_payment_list(:save => true) }
        post :create, :cash_payment_list => {'these' => 'params'}
        assigns(:cash_payment_list).should be(mock_cash_payment_list)
      end

      it "redirects to the created cash_payment_list" do
        CashPaymentList.stub(:new) { mock_cash_payment_list(:save => true) }
        post :create, :cash_payment_list => {}
        response.should redirect_to(cash_payment_list_url(mock_cash_payment_list))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cash_payment_list as @cash_payment_list" do
        CashPaymentList.stub(:new).with({'these' => 'params'}) { mock_cash_payment_list(:save => false) }
        post :create, :cash_payment_list => {'these' => 'params'}
        assigns(:cash_payment_list).should be(mock_cash_payment_list)
      end

      it "re-renders the 'new' template" do
        CashPaymentList.stub(:new) { mock_cash_payment_list(:save => false) }
        post :create, :cash_payment_list => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested cash_payment_list" do
        CashPaymentList.should_receive(:find).with("37") { mock_cash_payment_list }
        mock_cash_payment_list.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :cash_payment_list => {'these' => 'params'}
      end

      it "assigns the requested cash_payment_list as @cash_payment_list" do
        CashPaymentList.stub(:find) { mock_cash_payment_list(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:cash_payment_list).should be(mock_cash_payment_list)
      end

      it "redirects to the cash_payment_list" do
        CashPaymentList.stub(:find) { mock_cash_payment_list(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(cash_payment_list_url(mock_cash_payment_list))
      end
    end

    describe "with invalid params" do
      it "assigns the cash_payment_list as @cash_payment_list" do
        CashPaymentList.stub(:find) { mock_cash_payment_list(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:cash_payment_list).should be(mock_cash_payment_list)
      end

      it "re-renders the 'edit' template" do
        CashPaymentList.stub(:find) { mock_cash_payment_list(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested cash_payment_list" do
      CashPaymentList.should_receive(:find).with("37") { mock_cash_payment_list }
      mock_cash_payment_list.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the cash_payment_lists list" do
      CashPaymentList.stub(:find) { mock_cash_payment_list }
      delete :destroy, :id => "1"
      response.should redirect_to(cash_payment_lists_url)
    end
  end

end
