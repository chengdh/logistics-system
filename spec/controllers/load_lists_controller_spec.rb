require 'spec_helper'

describe LoadListsController do

  def mock_load_list(stubs={})
    (@mock_load_list ||= mock_model(LoadList).as_null_object).tap do |load_list|
      load_list.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all load_lists as @load_lists" do
      LoadList.stub(:all) { [mock_load_list] }
      get :index
      assigns(:load_lists).should eq([mock_load_list])
    end
  end

  describe "GET show" do
    it "assigns the requested load_list as @load_list" do
      LoadList.stub(:find).with("37") { mock_load_list }
      get :show, :id => "37"
      assigns(:load_list).should be(mock_load_list)
    end
  end

  describe "GET new" do
    it "assigns a new load_list as @load_list" do
      LoadList.stub(:new) { mock_load_list }
      get :new
      assigns(:load_list).should be(mock_load_list)
    end
  end

  describe "GET edit" do
    it "assigns the requested load_list as @load_list" do
      LoadList.stub(:find).with("37") { mock_load_list }
      get :edit, :id => "37"
      assigns(:load_list).should be(mock_load_list)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created load_list as @load_list" do
        LoadList.stub(:new).with({'these' => 'params'}) { mock_load_list(:save => true) }
        post :create, :load_list => {'these' => 'params'}
        assigns(:load_list).should be(mock_load_list)
      end

      it "redirects to the created load_list" do
        LoadList.stub(:new) { mock_load_list(:save => true) }
        post :create, :load_list => {}
        response.should redirect_to(load_list_url(mock_load_list))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved load_list as @load_list" do
        LoadList.stub(:new).with({'these' => 'params'}) { mock_load_list(:save => false) }
        post :create, :load_list => {'these' => 'params'}
        assigns(:load_list).should be(mock_load_list)
      end

      it "re-renders the 'new' template" do
        LoadList.stub(:new) { mock_load_list(:save => false) }
        post :create, :load_list => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested load_list" do
        LoadList.should_receive(:find).with("37") { mock_load_list }
        mock_load_list.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :load_list => {'these' => 'params'}
      end

      it "assigns the requested load_list as @load_list" do
        LoadList.stub(:find) { mock_load_list(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:load_list).should be(mock_load_list)
      end

      it "redirects to the load_list" do
        LoadList.stub(:find) { mock_load_list(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(load_list_url(mock_load_list))
      end
    end

    describe "with invalid params" do
      it "assigns the load_list as @load_list" do
        LoadList.stub(:find) { mock_load_list(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:load_list).should be(mock_load_list)
      end

      it "re-renders the 'edit' template" do
        LoadList.stub(:find) { mock_load_list(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested load_list" do
      LoadList.should_receive(:find).with("37") { mock_load_list }
      mock_load_list.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the load_lists list" do
      LoadList.stub(:find) { mock_load_list }
      delete :destroy, :id => "1"
      response.should redirect_to(load_lists_url)
    end
  end

end
