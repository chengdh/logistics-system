class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    render :js => "window.location='/403.html'"
  end
end
