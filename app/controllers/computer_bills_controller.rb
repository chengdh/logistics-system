#coding: utf-8
class ComputerBillsController < ApplicationController
  # GET /computer_bills
  # GET /computer_bills.xml
  def index
    @computer_bills = ComputerBill.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @computer_bills }
    end
  end

  # GET /computer_bills/1
  # GET /computer_bills/1.xml
  def show
    @computer_bill = ComputerBill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @computer_bill }
    end
  end

  # GET /computer_bills/new
  # GET /computer_bills/new.xml
  def new
    @computer_bill = ComputerBill.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @computer_bill }
    end
  end

  # GET /computer_bills/1/edit
  def edit
    @computer_bill = ComputerBill.find(params[:id])
  end

  # POST /computer_bills
  # POST /computer_bills.xml
  def create
    @computer_bill = ComputerBill.new(params[:computer_bill])

    respond_to do |format|
      if @computer_bill.save
        format.html { redirect_to(@computer_bill, :notice => 'Computer bill was successfully created.') }
        format.xml  { render :xml => @computer_bill, :status => :created, :location => @computer_bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @computer_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /computer_bills/1
  # PUT /computer_bills/1.xml
  def update
    @computer_bill = ComputerBill.find(params[:id])

    respond_to do |format|
      if @computer_bill.update_attributes(params[:computer_bill])
        format.html { redirect_to(@computer_bill, :notice => 'Computer bill was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @computer_bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /computer_bills/1
  # DELETE /computer_bills/1.xml
  def destroy
    @computer_bill = ComputerBill.find(params[:id])
    @computer_bill.destroy

    respond_to do |format|
      format.html { redirect_to(computer_bills_url) }
      format.xml  { head :ok }
    end
  end
end
