class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to root_url
  end
  
  private
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
  helper_method :current_user
  
  def authenticate 
    logged_in? ? true :access_denied
  end
  
  def logged_in?
    current_user.is_a? User
  end
  
  helper_method :logged_in?
  
  def access_denied
    redirect_to login_path, :notice =>"Please log in to continue" and return false
  end
  

end