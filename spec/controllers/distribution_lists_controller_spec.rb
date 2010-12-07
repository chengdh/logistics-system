require 'spec_helper'

describe DistributionListsController do

  def mock_distribution_list(stubs={})
    (@mock_distribution_list ||= mock_model(DistributionList).as_null_object).tap do |distribution_list|
      distribution_list.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all distribution_lists as @distribution_lists" do
      DistributionList.stub(:all) { [mock_distribution_list] }
      get :index
      assigns(:distribution_lists).should eq([mock_distribution_list])
    end
  end

  describe "GET show" do
    it "assigns the requested distribution_list as @distribution_list" do
      DistributionList.stub(:find).with("37") { mock_distribution_list }
      get :show, :id => "37"
      assigns(:distribution_list).should be(mock_distribution_list)
    end
  end

  describe "GET new" do
    it "assigns a new distribution_list as @distribution_list" do
      DistributionList.stub(:new) { mock_distribution_list }
      get :new
      assigns(:distribution_list).should be(mock_distribution_list)
    end
  end

  describe "GET edit" do
    it "assigns the requested distribution_list as @distribution_list" do
      DistributionList.stub(:find).with("37") { mock_distribution_list }
      get :edit, :id => "37"
      assigns(:distribution_list).should be(mock_distribution_list)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created distribution_list as @distribution_list" do
        DistributionList.stub(:new).with({'these' => 'params'}) { mock_distribution_list(:save => true) }
        post :create, :distribution_list => {'these' => 'params'}
        assigns(:distribution_list).should be(mock_distribution_list)
      end

      it "redirects to the created distribution_list" do
        DistributionList.stub(:new) { mock_distribution_list(:save => true) }
        post :create, :distribution_list => {}
        response.should redirect_to(distribution_list_url(mock_distribution_list))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved distribution_list as @distribution_list" do
        DistributionList.stub(:new).with({'these' => 'params'}) { mock_distribution_list(:save => false) }
        post :create, :distribution_list => {'these' => 'params'}
        assigns(:distribution_list).should be(mock_distribution_list)
      end

      it "re-renders the 'new' template" do
        DistributionList.stub(:new) { mock_distribution_list(:save => false) }
        post :create, :distribution_list => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested distribution_list" do
        DistributionList.should_receive(:find).with("37") { mock_distribution_list }
        mock_distribution_list.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :distribution_list => {'these' => 'params'}
      end

      it "assigns the requested distribution_list as @distribution_list" do
        DistributionList.stub(:find) { mock_distribution_list(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:distribution_list).should be(mock_distribution_list)
      end

      it "redirects to the distribution_list" do
        DistributionList.stub(:find) { mock_distribution_list(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(distribution_list_url(mock_distribution_list))
      end
    end

    describe "with invalid params" do
      it "assigns the distribution_list as @distribution_list" do
        DistributionList.stub(:find) { mock_distribution_list(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:distribution_list).should be(mock_distribution_list)
      end

      it "re-renders the 'edit' template" do
        DistributionList.stub(:find) { mock_distribution_list(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested distribution_list" do
      DistributionList.should_receive(:find).with("37") { mock_distribution_list }
      mock_distribution_list.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the distribution_lists list" do
      DistributionList.stub(:find) { mock_distribution_list }
      delete :destroy, :id => "1"
      response.should redirect_to(distribution_lists_url)
    end
  end

end
