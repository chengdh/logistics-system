class HandTransitBillsController < ApplicationController
  # GET /hand_transit_bills
  # GET /hand_transit_bills.xml
  def index
    @hand_transit_bills = HandTransitBill.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hand_transit_bills }
    end
  end

  # GET /hand_transit_bills/1
  # GET /hand_transit_bills/1.xml
  def show
    @hand_transit_bill = HandTransitBill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hand_transit_bill }
    end
  end

  # GET /hand_transit_bills/new
  # GET /hand_transit_bills/new.xml
  def new
    @hand_transit_bill = HandTransitBill.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hand_transit_bill }
    end
  end

  # GET /hand_transit_bills/1/edit
  def edit
    @hand_transit_bill = HandTransitBill.find(params[:id])
  end

  # POST /hand_transit_bills
  # POST /hand_transit_bills.xml
  def create
    @hand_transit_bill = HandTransitBill.new(params[:hand_transit_bill])

    respond_to do |format|
      if @hand_transit_bill.save
        format.html { redirect_to(@hand_transit_bill, :notice => 'Hand transit bill was successfully created.') }
        format.xml  { render :xml => @hand_transit_bill, :status => :created, :location => @hand_transit_bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hand_transit_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hand_transit_bills/1
  # PUT /hand_transit_bills/1.xml
  def update
    @hand_transit_bill = HandTransitBill.find(params[:id])

    respond_to do |format|
      if @hand_transit_bill.update_attributes(params[:hand_transit_bill])
        format.html { redirect_to(@hand_transit_bill, :notice => 'Hand transit bill was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hand_transit_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hand_transit_bills/1
  # DELETE /hand_transit_bills/1.xml
  def destroy
    @hand_transit_bill = HandTransitBill.find(params[:id])
    @hand_transit_bill.destroy

    respond_to do |format|
      format.html { redirect_to(hand_transit_bills_url) }
      format.xml  { head :ok }
    end
  end
end
