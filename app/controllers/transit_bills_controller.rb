class TransitBillsController < ApplicationController
  # GET /transit_bills
  # GET /transit_bills.xml
  def index
    @transit_bills = TransitBill.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transit_bills }
    end
  end

  # GET /transit_bills/1
  # GET /transit_bills/1.xml
  def show
    @transit_bill = TransitBill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transit_bill }
    end
  end

  # GET /transit_bills/new
  # GET /transit_bills/new.xml
  def new
    @transit_bill = TransitBill.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transit_bill }
    end
  end

  # GET /transit_bills/1/edit
  def edit
    @transit_bill = TransitBill.find(params[:id])
  end

  # POST /transit_bills
  # POST /transit_bills.xml
  def create
    @transit_bill = TransitBill.new(params[:transit_bill])

    respond_to do |format|
      if @transit_bill.save
        format.html { redirect_to(@transit_bill, :notice => 'Transit bill was successfully created.') }
        format.xml  { render :xml => @transit_bill, :status => :created, :location => @transit_bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transit_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transit_bills/1
  # PUT /transit_bills/1.xml
  def update
    @transit_bill = TransitBill.find(params[:id])

    respond_to do |format|
      if @transit_bill.update_attributes(params[:transit_bill])
        format.html { redirect_to(@transit_bill, :notice => 'Transit bill was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transit_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /transit_bills/1
  # DELETE /transit_bills/1.xml
  def destroy
    @transit_bill = TransitBill.find(params[:id])
    @transit_bill.destroy

    respond_to do |format|
      format.html { redirect_to(transit_bills_url) }
      format.xml  { head :ok }
    end
  end
end
