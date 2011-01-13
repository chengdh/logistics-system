require 'spec_helper'

describe TransitDeliverInfosController do
  login_admin
  render_views
  describe "GET index" do
    it "should be success" do
      Factory(:transit_deliver_info_with_bill)
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    it "assigns the requested cash_pay_info as @transit_deliver_info" do
      td = Factory(:transit_deliver_info_with_bill)
      get :show, :id => td
      assigns(:transit_deliver_info).should == td
    end
  end

  describe "GET new" do
    it "should be success" do
      get :new
      response.should be_success
    end
  end

  describe "POST create" do
    before(:each) do
      @transit_bill = Factory(:transit_bill_transited)
    end

    describe "with valid params" do
      it "success create cash_pay_info" do
        lambda do
          post :create,:transit_deliver_info => {:org_id => Factory(:zz),:transit_hand_fee => 10},:bill_ids => [@transit_bill.id]
        end.should change(TransitDeliverInfo,:count).by(1)
      end

      it "redirects to the created cash_pay_info" do
          post :create,:transit_deliver_info => {:org_id => Factory(:zz),:transit_hand_fee => 10},:bill_ids => [@transit_bill.id]
        response.should redirect_to(assigns(:transit_deliver_info))
      end
    end

    describe "with invalid params" do
      it "re-render the new 'template'" do
        post :create, :transit_deliver_info => {}
        response.should render_template('new')
      end
    end
  end
end
