class LoadListsController < ApplicationController
  # GET /load_lists
  # GET /load_lists.xml
  def index
    @load_lists = LoadList.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @load_lists }
    end
  end

  # GET /load_lists/1
  # GET /load_lists/1.xml
  def show
    @load_list = LoadList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @load_list }
    end
  end

  # GET /load_lists/new
  # GET /load_lists/new.xml
  def new
    @load_list = LoadList.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @load_list }
    end
  end

  # GET /load_lists/1/edit
  def edit
    @load_list = LoadList.find(params[:id])
  end

  # POST /load_lists
  # POST /load_lists.xml
  def create
    @load_list = LoadList.new(params[:load_list])

    respond_to do |format|
      if @load_list.save
        format.html { redirect_to(@load_list, :notice => 'Load list was successfully created.') }
        format.xml  { render :xml => @load_list, :status => :created, :location => @load_list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @load_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /load_lists/1
  # PUT /load_lists/1.xml
  def update
    @load_list = LoadList.find(params[:id])

    respond_to do |format|
      if @load_list.update_attributes(params[:load_list])
        format.html { redirect_to(@load_list, :notice => 'Load list was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @load_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /load_lists/1
  # DELETE /load_lists/1.xml
  def destroy
    @load_list = LoadList.find(params[:id])
    @load_list.destroy

    respond_to do |format|
      format.html { redirect_to(load_lists_url) }
      format.xml  { head :ok }
    end
  end
end
