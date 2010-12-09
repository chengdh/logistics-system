require 'spec_helper'

describe DeliverInfosController do

  def mock_deliver_info(stubs={})
    (@mock_deliver_info ||= mock_model(DeliverInfo).as_null_object).tap do |deliver_info|
      deliver_info.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all deliver_infos as @deliver_infos" do
      DeliverInfo.stub(:all) { [mock_deliver_info] }
      get :index
      assigns(:deliver_infos).should eq([mock_deliver_info])
    end
  end

  describe "GET show" do
    it "assigns the requested deliver_info as @deliver_info" do
      DeliverInfo.stub(:find).with("37") { mock_deliver_info }
      get :show, :id => "37"
      assigns(:deliver_info).should be(mock_deliver_info)
    end
  end

  describe "GET new" do
    it "assigns a new deliver_info as @deliver_info" do
      DeliverInfo.stub(:new) { mock_deliver_info }
      get :new
      assigns(:deliver_info).should be(mock_deliver_info)
    end
  end

  describe "GET edit" do
    it "assigns the requested deliver_info as @deliver_info" do
      DeliverInfo.stub(:find).with("37") { mock_deliver_info }
      get :edit, :id => "37"
      assigns(:deliver_info).should be(mock_deliver_info)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created deliver_info as @deliver_info" do
        DeliverInfo.stub(:new).with({'these' => 'params'}) { mock_deliver_info(:save => true) }
        post :create, :deliver_info => {'these' => 'params'}
        assigns(:deliver_info).should be(mock_deliver_info)
      end

      it "redirects to the created deliver_info" do
        DeliverInfo.stub(:new) { mock_deliver_info(:save => true) }
        post :create, :deliver_info => {}
        response.should redirect_to(deliver_info_url(mock_deliver_info))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved deliver_info as @deliver_info" do
        DeliverInfo.stub(:new).with({'these' => 'params'}) { mock_deliver_info(:save => false) }
        post :create, :deliver_info => {'these' => 'params'}
        assigns(:deliver_info).should be(mock_deliver_info)
      end

      it "re-renders the 'new' template" do
        DeliverInfo.stub(:new) { mock_deliver_info(:save => false) }
        post :create, :deliver_info => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested deliver_info" do
        DeliverInfo.should_receive(:find).with("37") { mock_deliver_info }
        mock_deliver_info.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :deliver_info => {'these' => 'params'}
      end

      it "assigns the requested deliver_info as @deliver_info" do
        DeliverInfo.stub(:find) { mock_deliver_info(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:deliver_info).should be(mock_deliver_info)
      end

      it "redirects to the deliver_info" do
        DeliverInfo.stub(:find) { mock_deliver_info(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(deliver_info_url(mock_deliver_info))
      end
    end

    describe "with invalid params" do
      it "assigns the deliver_info as @deliver_info" do
        DeliverInfo.stub(:find) { mock_deliver_info(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:deliver_info).should be(mock_deliver_info)
      end

      it "re-renders the 'edit' template" do
        DeliverInfo.stub(:find) { mock_deliver_info(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested deliver_info" do
      DeliverInfo.should_receive(:find).with("37") { mock_deliver_info }
      mock_deliver_info.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the deliver_infos list" do
      DeliverInfo.stub(:find) { mock_deliver_info }
      delete :destroy, :id => "1"
      response.should redirect_to(deliver_infos_url)
    end
  end

end
