require 'spec_helper'

describe BanksController do

  def mock_bank(stubs={})
    (@mock_bank ||= mock_model(Bank).as_null_object).tap do |bank|
      bank.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all banks as @banks" do
      Bank.stub(:all) { [mock_bank] }
      get :index
      assigns(:banks).should eq([mock_bank])
    end
  end

  describe "GET show" do
    it "assigns the requested bank as @bank" do
      Bank.stub(:find).with("37") { mock_bank }
      get :show, :id => "37"
      assigns(:bank).should be(mock_bank)
    end
  end

  describe "GET new" do
    it "assigns a new bank as @bank" do
      Bank.stub(:new) { mock_bank }
      get :new
      assigns(:bank).should be(mock_bank)
    end
  end

  describe "GET edit" do
    it "assigns the requested bank as @bank" do
      Bank.stub(:find).with("37") { mock_bank }
      get :edit, :id => "37"
      assigns(:bank).should be(mock_bank)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created bank as @bank" do
        Bank.stub(:new).with({'these' => 'params'}) { mock_bank(:save => true) }
        post :create, :bank => {'these' => 'params'}
        assigns(:bank).should be(mock_bank)
      end

      it "redirects to the created bank" do
        Bank.stub(:new) { mock_bank(:save => true) }
        post :create, :bank => {}
        response.should redirect_to(bank_url(mock_bank))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bank as @bank" do
        Bank.stub(:new).with({'these' => 'params'}) { mock_bank(:save => false) }
        post :create, :bank => {'these' => 'params'}
        assigns(:bank).should be(mock_bank)
      end

      it "re-renders the 'new' template" do
        Bank.stub(:new) { mock_bank(:save => false) }
        post :create, :bank => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested bank" do
        Bank.should_receive(:find).with("37") { mock_bank }
        mock_bank.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :bank => {'these' => 'params'}
      end

      it "assigns the requested bank as @bank" do
        Bank.stub(:find) { mock_bank(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:bank).should be(mock_bank)
      end

      it "redirects to the bank" do
        Bank.stub(:find) { mock_bank(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(bank_url(mock_bank))
      end
    end

    describe "with invalid params" do
      it "assigns the bank as @bank" do
        Bank.stub(:find) { mock_bank(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:bank).should be(mock_bank)
      end

      it "re-renders the 'edit' template" do
        Bank.stub(:find) { mock_bank(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested bank" do
      Bank.should_receive(:find).with("37") { mock_bank }
      mock_bank.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the banks list" do
      Bank.stub(:find) { mock_bank }
      delete :destroy, :id => "1"
      response.should redirect_to(banks_url)
    end
  end

end
