require 'spec_helper'

describe BranchesController do

  def mock_branch(stubs={})
    (@mock_branch ||= mock_model(Branch).as_null_object).tap do |branch|
      branch.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all branches as @branches" do
      Branch.stub(:all) { [mock_branch] }
      get :index
      assigns(:branches).should eq([mock_branch])
    end
  end

  describe "GET show" do
    it "assigns the requested branch as @branch" do
      Branch.stub(:find).with("37") { mock_branch }
      get :show, :id => "37"
      assigns(:branch).should be(mock_branch)
    end
  end

  describe "GET new" do
    it "assigns a new branch as @branch" do
      Branch.stub(:new) { mock_branch }
      get :new
      assigns(:branch).should be(mock_branch)
    end
  end

  describe "GET edit" do
    it "assigns the requested branch as @branch" do
      Branch.stub(:find).with("37") { mock_branch }
      get :edit, :id => "37"
      assigns(:branch).should be(mock_branch)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created branch as @branch" do
        Branch.stub(:new).with({'these' => 'params'}) { mock_branch(:save => true) }
        post :create, :branch => {'these' => 'params'}
        assigns(:branch).should be(mock_branch)
      end

      it "redirects to the created branch" do
        Branch.stub(:new) { mock_branch(:save => true) }
        post :create, :branch => {}
        response.should redirect_to(branch_url(mock_branch))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved branch as @branch" do
        Branch.stub(:new).with({'these' => 'params'}) { mock_branch(:save => false) }
        post :create, :branch => {'these' => 'params'}
        assigns(:branch).should be(mock_branch)
      end

      it "re-renders the 'new' template" do
        Branch.stub(:new) { mock_branch(:save => false) }
        post :create, :branch => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested branch" do
        Branch.should_receive(:find).with("37") { mock_branch }
        mock_branch.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :branch => {'these' => 'params'}
      end

      it "assigns the requested branch as @branch" do
        Branch.stub(:find) { mock_branch(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:branch).should be(mock_branch)
      end

      it "redirects to the branch" do
        Branch.stub(:find) { mock_branch(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(branch_url(mock_branch))
      end
    end

    describe "with invalid params" do
      it "assigns the branch as @branch" do
        Branch.stub(:find) { mock_branch(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:branch).should be(mock_branch)
      end

      it "re-renders the 'edit' template" do
        Branch.stub(:find) { mock_branch(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested branch" do
      Branch.should_receive(:find).with("37") { mock_branch }
      mock_branch.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the branches list" do
      Branch.stub(:find) { mock_branch }
      delete :destroy, :id => "1"
      response.should redirect_to(branches_url)
    end
  end

end
