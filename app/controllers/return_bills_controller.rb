class ReturnBillsController < ApplicationController
  # GET /return_bills
  # GET /return_bills.xml
  def index
    @return_bills = ReturnBill.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @return_bills }
    end
  end

  # GET /return_bills/1
  # GET /return_bills/1.xml
  def show
    @return_bill = ReturnBill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @return_bill }
    end
  end

  # GET /return_bills/new
  # GET /return_bills/new.xml
  def new
    @return_bill = ReturnBill.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @return_bill }
    end
  end

  # GET /return_bills/1/edit
  def edit
    @return_bill = ReturnBill.find(params[:id])
  end

  # POST /return_bills
  # POST /return_bills.xml
  def create
    @return_bill = ReturnBill.new(params[:return_bill])

    respond_to do |format|
      if @return_bill.save
        format.html { redirect_to(@return_bill, :notice => 'Return bill was successfully created.') }
        format.xml  { render :xml => @return_bill, :status => :created, :location => @return_bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @return_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /return_bills/1
  # PUT /return_bills/1.xml
  def update
    @return_bill = ReturnBill.find(params[:id])

    respond_to do |format|
      if @return_bill.update_attributes(params[:return_bill])
        format.html { redirect_to(@return_bill, :notice => 'Return bill was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @return_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /return_bills/1
  # DELETE /return_bills/1.xml
  def destroy
    @return_bill = ReturnBill.find(params[:id])
    @return_bill.destroy

    respond_to do |format|
      format.html { redirect_to(return_bills_url) }
      format.xml  { head :ok }
    end
  end
end
