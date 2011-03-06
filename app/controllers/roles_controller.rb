#coding: utf-8
class RolesController < BaseController
  def new
    @role = Role.new_with_default
  end
end
