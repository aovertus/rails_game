class SessionsController < ApplicationController
  def create 
    if env["omniauth.auth"]
      user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_url
    elsif user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Successfully connected"
    else
      flash.now[:alert] = "Invalid combinaison for login/password"
      render :action => "new"
    end
  end
  
  def destroy
    reset_session
    redirect_to root_path, :notice => "Successfully logged out"
  end
end
