require 'spec_helper'

describe SettlementsController do

  def mock_settlement(stubs={})
    (@mock_settlement ||= mock_model(Settlement).as_null_object).tap do |settlement|
      settlement.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all settlements as @settlements" do
      Settlement.stub(:all) { [mock_settlement] }
      get :index
      assigns(:settlements).should eq([mock_settlement])
    end
  end

  describe "GET show" do
    it "assigns the requested settlement as @settlement" do
      Settlement.stub(:find).with("37") { mock_settlement }
      get :show, :id => "37"
      assigns(:settlement).should be(mock_settlement)
    end
  end

  describe "GET new" do
    it "assigns a new settlement as @settlement" do
      Settlement.stub(:new) { mock_settlement }
      get :new
      assigns(:settlement).should be(mock_settlement)
    end
  end

  describe "GET edit" do
    it "assigns the requested settlement as @settlement" do
      Settlement.stub(:find).with("37") { mock_settlement }
      get :edit, :id => "37"
      assigns(:settlement).should be(mock_settlement)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created settlement as @settlement" do
        Settlement.stub(:new).with({'these' => 'params'}) { mock_settlement(:save => true) }
        post :create, :settlement => {'these' => 'params'}
        assigns(:settlement).should be(mock_settlement)
      end

      it "redirects to the created settlement" do
        Settlement.stub(:new) { mock_settlement(:save => true) }
        post :create, :settlement => {}
        response.should redirect_to(settlement_url(mock_settlement))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved settlement as @settlement" do
        Settlement.stub(:new).with({'these' => 'params'}) { mock_settlement(:save => false) }
        post :create, :settlement => {'these' => 'params'}
        assigns(:settlement).should be(mock_settlement)
      end

      it "re-renders the 'new' template" do
        Settlement.stub(:new) { mock_settlement(:save => false) }
        post :create, :settlement => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested settlement" do
        Settlement.should_receive(:find).with("37") { mock_settlement }
        mock_settlement.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :settlement => {'these' => 'params'}
      end

      it "assigns the requested settlement as @settlement" do
        Settlement.stub(:find) { mock_settlement(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:settlement).should be(mock_settlement)
      end

      it "redirects to the settlement" do
        Settlement.stub(:find) { mock_settlement(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(settlement_url(mock_settlement))
      end
    end

    describe "with invalid params" do
      it "assigns the settlement as @settlement" do
        Settlement.stub(:find) { mock_settlement(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:settlement).should be(mock_settlement)
      end

      it "re-renders the 'edit' template" do
        Settlement.stub(:find) { mock_settlement(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested settlement" do
      Settlement.should_receive(:find).with("37") { mock_settlement }
      mock_settlement.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the settlements list" do
      Settlement.stub(:find) { mock_settlement }
      delete :destroy, :id => "1"
      response.should redirect_to(settlements_url)
    end
  end

end
