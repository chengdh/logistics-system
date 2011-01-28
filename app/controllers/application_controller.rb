class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    render :js => "window.location='/403.html'"
  end
end
