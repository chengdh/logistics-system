#coding: utf-8
class BaseController < ApplicationController
  respond_to :html,:xml
  before_filter :get_model_klazz,:create_search
  # GET /the_models
  # GET /the_models.xml
  def index
    the_models = @search.paginate :page => params[:page],:order => "created_at DESC"

    instance_variable_set("@#{@param_name.tableize}",the_models)
    respond_with the_models
  end

  # GET /the_models/1
  # GET /the_models/1.xml
  def show
    the_model = @model_klazz.find(params[:id])
    instance_variable_set("@#{@param_name}",the_model)
    respond_with the_model
  end

  # GET /the_models/new
  # GET /the_models/new.xml
  def new
    the_model = @model_klazz.new
    instance_variable_set("@#{@param_name}",the_model)
    respond_with the_model
  end

  # GET /the_models/1/edit
  def edit
    the_model = @model_klazz.find(params[:id])
    instance_variable_set("@#{@param_name}",the_model)
    respond_with the_model
  end

  # POST /the_models
  # POST /the_models.xml
  def create
    the_model = @model_klazz.new(params[@param_name])

    instance_variable_set("@#{@param_name}",the_model)
    if the_model.save
      flash[:notice] = "#{@model_klazz.model_name.human}更新成功."
    end
    respond_with the_model

  end

  # PUT /the_models/1
  # PUT /the_models/1.xml
  def update
    the_model = @model_klazz.find(params[:id])
    instance_variable_set("@#{@param_name}",the_model)
    if the_model.update_attributes(params[@param_name])
      flash[:notice] = "#{@model_klazz.model_name.human}更新成功."
    end
    respond_with the_model
  end

  # DELETE /the_models/1
  # DELETE /the_models/1.xml
  def destroy
    the_model = @model_klazz.find(params[:id])
    the_model.destroy

    flash[:notice] = "#{@model_klazz.model_name.human} 已被删除."
    respond_with the_model
  end
  protected
  #根据请求的url名称得到该controller对应的model类名和参数名
  def get_model_klazz
    #注: controller_name 返回形式为复数 例如Bills/Confirms
    @model_klazz = controller_name.classify.constantize
    @param_name = controller_name.singularize.downcase
  end
  #生成@search对象
  def create_search
    @search = @model_klazz.search(params[:search])
  end
end
