require 'spec_helper'

describe RefoundsController do

  def mock_refound(stubs={})
    (@mock_refound ||= mock_model(Refound).as_null_object).tap do |refound|
      refound.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all refounds as @refounds" do
      Refound.stub(:all) { [mock_refound] }
      get :index
      assigns(:refounds).should eq([mock_refound])
    end
  end

  describe "GET show" do
    it "assigns the requested refound as @refound" do
      Refound.stub(:find).with("37") { mock_refound }
      get :show, :id => "37"
      assigns(:refound).should be(mock_refound)
    end
  end

  describe "GET new" do
    it "assigns a new refound as @refound" do
      Refound.stub(:new) { mock_refound }
      get :new
      assigns(:refound).should be(mock_refound)
    end
  end

  describe "GET edit" do
    it "assigns the requested refound as @refound" do
      Refound.stub(:find).with("37") { mock_refound }
      get :edit, :id => "37"
      assigns(:refound).should be(mock_refound)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created refound as @refound" do
        Refound.stub(:new).with({'these' => 'params'}) { mock_refound(:save => true) }
        post :create, :refound => {'these' => 'params'}
        assigns(:refound).should be(mock_refound)
      end

      it "redirects to the created refound" do
        Refound.stub(:new) { mock_refound(:save => true) }
        post :create, :refound => {}
        response.should redirect_to(refound_url(mock_refound))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved refound as @refound" do
        Refound.stub(:new).with({'these' => 'params'}) { mock_refound(:save => false) }
        post :create, :refound => {'these' => 'params'}
        assigns(:refound).should be(mock_refound)
      end

      it "re-renders the 'new' template" do
        Refound.stub(:new) { mock_refound(:save => false) }
        post :create, :refound => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested refound" do
        Refound.should_receive(:find).with("37") { mock_refound }
        mock_refound.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :refound => {'these' => 'params'}
      end

      it "assigns the requested refound as @refound" do
        Refound.stub(:find) { mock_refound(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:refound).should be(mock_refound)
      end

      it "redirects to the refound" do
        Refound.stub(:find) { mock_refound(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(refound_url(mock_refound))
      end
    end

    describe "with invalid params" do
      it "assigns the refound as @refound" do
        Refound.stub(:find) { mock_refound(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:refound).should be(mock_refound)
      end

      it "re-renders the 'edit' template" do
        Refound.stub(:find) { mock_refound(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested refound" do
      Refound.should_receive(:find).with("37") { mock_refound }
      mock_refound.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the refounds list" do
      Refound.stub(:find) { mock_refound }
      delete :destroy, :id => "1"
      response.should redirect_to(refounds_url)
    end
  end

end
