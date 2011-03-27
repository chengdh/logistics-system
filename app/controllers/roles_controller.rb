#coding: utf-8
class RolesController < BaseController
  def new
    @role = Role.new_with_default
  end
  def edit
    @role = Role.with_association.find(params[:id])
  end
end
