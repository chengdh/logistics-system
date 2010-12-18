require 'spec_helper'

describe TransferPayInfosController do

  def mock_transfer_pay_info(stubs={})
    (@mock_transfer_pay_info ||= mock_model(TransferPayInfo).as_null_object).tap do |transfer_pay_info|
      transfer_pay_info.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all transfer_pay_infos as @transfer_pay_infos" do
      TransferPayInfo.stub(:all) { [mock_transfer_pay_info] }
      get :index
      assigns(:transfer_pay_infos).should eq([mock_transfer_pay_info])
    end
  end

  describe "GET show" do
    it "assigns the requested transfer_pay_info as @transfer_pay_info" do
      TransferPayInfo.stub(:find).with("37") { mock_transfer_pay_info }
      get :show, :id => "37"
      assigns(:transfer_pay_info).should be(mock_transfer_pay_info)
    end
  end

  describe "GET new" do
    it "assigns a new transfer_pay_info as @transfer_pay_info" do
      TransferPayInfo.stub(:new) { mock_transfer_pay_info }
      get :new
      assigns(:transfer_pay_info).should be(mock_transfer_pay_info)
    end
  end

  describe "GET edit" do
    it "assigns the requested transfer_pay_info as @transfer_pay_info" do
      TransferPayInfo.stub(:find).with("37") { mock_transfer_pay_info }
      get :edit, :id => "37"
      assigns(:transfer_pay_info).should be(mock_transfer_pay_info)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created transfer_pay_info as @transfer_pay_info" do
        TransferPayInfo.stub(:new).with({'these' => 'params'}) { mock_transfer_pay_info(:save => true) }
        post :create, :transfer_pay_info => {'these' => 'params'}
        assigns(:transfer_pay_info).should be(mock_transfer_pay_info)
      end

      it "redirects to the created transfer_pay_info" do
        TransferPayInfo.stub(:new) { mock_transfer_pay_info(:save => true) }
        post :create, :transfer_pay_info => {}
        response.should redirect_to(transfer_pay_info_url(mock_transfer_pay_info))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved transfer_pay_info as @transfer_pay_info" do
        TransferPayInfo.stub(:new).with({'these' => 'params'}) { mock_transfer_pay_info(:save => false) }
        post :create, :transfer_pay_info => {'these' => 'params'}
        assigns(:transfer_pay_info).should be(mock_transfer_pay_info)
      end

      it "re-renders the 'new' template" do
        TransferPayInfo.stub(:new) { mock_transfer_pay_info(:save => false) }
        post :create, :transfer_pay_info => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested transfer_pay_info" do
        TransferPayInfo.should_receive(:find).with("37") { mock_transfer_pay_info }
        mock_transfer_pay_info.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :transfer_pay_info => {'these' => 'params'}
      end

      it "assigns the requested transfer_pay_info as @transfer_pay_info" do
        TransferPayInfo.stub(:find) { mock_transfer_pay_info(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:transfer_pay_info).should be(mock_transfer_pay_info)
      end

      it "redirects to the transfer_pay_info" do
        TransferPayInfo.stub(:find) { mock_transfer_pay_info(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(transfer_pay_info_url(mock_transfer_pay_info))
      end
    end

    describe "with invalid params" do
      it "assigns the transfer_pay_info as @transfer_pay_info" do
        TransferPayInfo.stub(:find) { mock_transfer_pay_info(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:transfer_pay_info).should be(mock_transfer_pay_info)
      end

      it "re-renders the 'edit' template" do
        TransferPayInfo.stub(:find) { mock_transfer_pay_info(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested transfer_pay_info" do
      TransferPayInfo.should_receive(:find).with("37") { mock_transfer_pay_info }
      mock_transfer_pay_info.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the transfer_pay_infos list" do
      TransferPayInfo.stub(:find) { mock_transfer_pay_info }
      delete :destroy, :id => "1"
      response.should redirect_to(transfer_pay_infos_url)
    end
  end

end
