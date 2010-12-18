require 'spec_helper'

describe CashPayInfosController do

  def mock_cash_pay_info(stubs={})
    (@mock_cash_pay_info ||= mock_model(CashPayInfo).as_null_object).tap do |cash_pay_info|
      cash_pay_info.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all cash_pay_infos as @cash_pay_infos" do
      CashPayInfo.stub(:all) { [mock_cash_pay_info] }
      get :index
      assigns(:cash_pay_infos).should eq([mock_cash_pay_info])
    end
  end

  describe "GET show" do
    it "assigns the requested cash_pay_info as @cash_pay_info" do
      CashPayInfo.stub(:find).with("37") { mock_cash_pay_info }
      get :show, :id => "37"
      assigns(:cash_pay_info).should be(mock_cash_pay_info)
    end
  end

  describe "GET new" do
    it "assigns a new cash_pay_info as @cash_pay_info" do
      CashPayInfo.stub(:new) { mock_cash_pay_info }
      get :new
      assigns(:cash_pay_info).should be(mock_cash_pay_info)
    end
  end

  describe "GET edit" do
    it "assigns the requested cash_pay_info as @cash_pay_info" do
      CashPayInfo.stub(:find).with("37") { mock_cash_pay_info }
      get :edit, :id => "37"
      assigns(:cash_pay_info).should be(mock_cash_pay_info)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created cash_pay_info as @cash_pay_info" do
        CashPayInfo.stub(:new).with({'these' => 'params'}) { mock_cash_pay_info(:save => true) }
        post :create, :cash_pay_info => {'these' => 'params'}
        assigns(:cash_pay_info).should be(mock_cash_pay_info)
      end

      it "redirects to the created cash_pay_info" do
        CashPayInfo.stub(:new) { mock_cash_pay_info(:save => true) }
        post :create, :cash_pay_info => {}
        response.should redirect_to(cash_pay_info_url(mock_cash_pay_info))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cash_pay_info as @cash_pay_info" do
        CashPayInfo.stub(:new).with({'these' => 'params'}) { mock_cash_pay_info(:save => false) }
        post :create, :cash_pay_info => {'these' => 'params'}
        assigns(:cash_pay_info).should be(mock_cash_pay_info)
      end

      it "re-renders the 'new' template" do
        CashPayInfo.stub(:new) { mock_cash_pay_info(:save => false) }
        post :create, :cash_pay_info => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested cash_pay_info" do
        CashPayInfo.should_receive(:find).with("37") { mock_cash_pay_info }
        mock_cash_pay_info.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :cash_pay_info => {'these' => 'params'}
      end

      it "assigns the requested cash_pay_info as @cash_pay_info" do
        CashPayInfo.stub(:find) { mock_cash_pay_info(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:cash_pay_info).should be(mock_cash_pay_info)
      end

      it "redirects to the cash_pay_info" do
        CashPayInfo.stub(:find) { mock_cash_pay_info(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(cash_pay_info_url(mock_cash_pay_info))
      end
    end

    describe "with invalid params" do
      it "assigns the cash_pay_info as @cash_pay_info" do
        CashPayInfo.stub(:find) { mock_cash_pay_info(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:cash_pay_info).should be(mock_cash_pay_info)
      end

      it "re-renders the 'edit' template" do
        CashPayInfo.stub(:find) { mock_cash_pay_info(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested cash_pay_info" do
      CashPayInfo.should_receive(:find).with("37") { mock_cash_pay_info }
      mock_cash_pay_info.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the cash_pay_infos list" do
      CashPayInfo.stub(:find) { mock_cash_pay_info }
      delete :destroy, :id => "1"
      response.should redirect_to(cash_pay_infos_url)
    end
  end

end
