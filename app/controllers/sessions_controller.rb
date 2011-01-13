#coding: utf-8
class SessionsController < Devise::SessionsController
  #GET /sessions/new_session_default
  def new_session_default
  end
  #PUT update_session_default
  def update_session_default
    current_user.update_attributes(:default_role_id => params[:cur_role_id],:default_org_id => params[:cur_org_id])
    redirect_to root_path
  end
  private
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope      = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    redirect_to after_sign_in_path_for(resource) || stored_location_for(scope)
  end
end
