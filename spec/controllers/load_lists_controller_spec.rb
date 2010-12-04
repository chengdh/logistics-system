#coding：utf-8
require 'spec_helper'

describe LoadListsController do
  render_views

  before(:each) do
    @computer_bill = Factory(:computer_bill)
    @bill_ids =[@computer_bill.id] 
    @load_list = Factory(:load_list)
  end

  describe "GET index" do
    it "should be success" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    it "should render 'show'" do
      get :show, :id => @load_list
      response.should render_template('show')
    end
  end

  describe "GET new" do
    it "should be sucesss" do
      get :new
      response.should be_success
    end
    it "should render template 'new'" do
      get :new
      response.should render_template('new')
    end
  end

  describe "GET edit" do
    it "should be success" do
      get :edit, :id => @load_list 
      response.should be_success
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "the load_list should success create" do
        lambda do
          post :create,:load_list => {:from_org_id => Factory(:zz),:to_org_id => Factory(:ay)},:bill_ids => @bill_ids
        end.should change(LoadList,:count).by(1)
      end

      it "redirects to the created load_list" do
        post :create,:load_list => {:from_org_id => Factory(:zz),:to_org_id => Factory(:ay)},:bill_ids => @bill_ids
        response.should redirect_to(load_list_url(assigns(:load_list)))
      end

      it "after created the contained carrying_bill state is 'loaded'" do
        post :create,:load_list => {:from_org_id => Factory(:zz),:to_org_id => Factory(:ay)},:bill_ids => @bill_ids
        @computer_bill.reload
        @computer_bill.should be_loaded
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, :load_list => {:bill_no => "bill_no"},:bill_ids => @bill_ids
        response.should render_template('new')
      end

    end

  end


  describe "DELETE destroy" do
    it "destroys the requested load_list" do
      lambda do
        delete :destroy ,:id => @load_list
      end.should change(LoadList,:count).by(-1)
    end

    it "redirects to the load_lists list" do
      delete :destroy, :id => @load_list
      response.should redirect_to(load_lists_url)
    end
  end
  #启动流程处理
  describe "PUT process" do
    it "load_list state should become shipped" do
      loaded_list = Factory(:loaded_list)
      put :process,:id =>loaded_list 
      response.should be_success
      loaded_list.reload
      loaded_list.should be_shipped
      @computer_bill.reload
      @computer_bill.should be_shipped
    end
  end

end
