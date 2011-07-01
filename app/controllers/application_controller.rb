class ApplicationController < ActionController::Base
  include ControllerAuthentication
  before_filter :login_required
  before_filter :current_user if :logged_in?
  protect_from_forgery

end

