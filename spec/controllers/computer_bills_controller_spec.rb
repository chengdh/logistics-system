#coding: utf-8
require 'spec_helper'

describe ComputerBillsController do
  render_views

  before(:each) do
    @computer_bill = Factory(:computer_bill)
  end


  describe "GET index" do
    it "assigns all computer_bills as @computer_bills" do
      get :index
      assigns(:computer_bills).should be_include(@computer_bill)
    end
  end

  describe "GET show" do

    it "should be success" do
      get :show, :id => @computer_bill
      response.should be_success
    end

    it "assigns the requested computer_bill as @computer_bill" do
      get :show, :id => @computer_bill
      assigns(:computer_bill).should == @computer_bill
    end
  end

  describe "GET new" do
    it "should be success" do
      get :new
      response.should be_success
    end
  end

  describe "GET edit" do
    it "assigns the requested computer_bill as @computer_bill" do
      get :edit, :id => @computer_bill
      assigns(:computer_bill).should == @computer_bill
    end
  end

  describe "POST create" do
    before(:each) do
      @attr = Factory.build(:computer_bill).attributes
    end
    describe "success" do
      it "能够成功保存票据信息" do
        lambda do
          post :create, :computer_bill => @attr
        end.should change(ComputerBill,:count).by(1)
      end

      it "redirects to the created computer_bill" do
        post :create, :computer_bill => @attr
        response.should redirect_to(computer_bill_path(assigns(:computer_bill)))
      end
    end

    describe "with invalid params" do

      it "re-renders the 'new' template" do
        post :create, :computer_bill => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do
    before :each do
      @attr = {:goods_info => 'change_goods_info',:from_customer_name => 'changed customer name'}
    end

    describe "with valid params" do
      it "updates the requested computer_bill" do
        put :update, :id => @computer_bill, :computer_bill => @attr 
        @computer_bill.reload
        @computer_bill.goods_info.should == @attr[:goods_info]
        @computer_bill.from_customer_name.should == @attr[:from_customer_name]
      end


      it "redirects to the computer_bill" do
        put :update, :id => @computer_bill,:computer_bill => @attr
        response.should redirect_to(computer_bill_path(@computer_bill))
      end
    end

    describe "with invalid params" do
      it "assigns the computer_bill as @computer_bill" do
        put :update, :id => @computer_bill 
        assigns(:computer_bill).should == @computer_bill
      end

      it "re-renders the 'edit' template" do
        put :update, :id => @computer_bill,:computer_bill => {:from_org_id => nil}
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested computer_bill" do
      lambda do
        request.env["HTTP_REFERER"] = computer_bills_url
        delete :destroy, :id => @computer_bill 
      end.should change(ComputerBill,:count).by(-1)
    end

    it "redirects to the computer_bills list" do
      request.env["HTTP_REFERER"] = computer_bills_url
      delete :destroy, :id => @computer_bill 
      response.should redirect_to(computer_bills_url)
    end
  end
end
