class HandBillsController < ApplicationController
  # GET /hand_bills
  # GET /hand_bills.xml
  def index
    @hand_bills = HandBill.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hand_bills }
    end
  end

  # GET /hand_bills/1
  # GET /hand_bills/1.xml
  def show
    @hand_bill = HandBill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hand_bill }
    end
  end

  # GET /hand_bills/new
  # GET /hand_bills/new.xml
  def new
    @hand_bill = HandBill.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hand_bill }
    end
  end

  # GET /hand_bills/1/edit
  def edit
    @hand_bill = HandBill.find(params[:id])
  end

  # POST /hand_bills
  # POST /hand_bills.xml
  def create
    @hand_bill = HandBill.new(params[:hand_bill])

    respond_to do |format|
      if @hand_bill.save
        format.html { redirect_to(@hand_bill, :notice => 'Hand bill was successfully created.') }
        format.xml  { render :xml => @hand_bill, :status => :created, :location => @hand_bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hand_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hand_bills/1
  # PUT /hand_bills/1.xml
  def update
    @hand_bill = HandBill.find(params[:id])

    respond_to do |format|
      if @hand_bill.update_attributes(params[:hand_bill])
        format.html { redirect_to(@hand_bill, :notice => 'Hand bill was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hand_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hand_bills/1
  # DELETE /hand_bills/1.xml
  def destroy
    @hand_bill = HandBill.find(params[:id])
    @hand_bill.destroy

    respond_to do |format|
      format.html { redirect_to(hand_bills_url) }
      format.xml  { head :ok }
    end
  end
end
