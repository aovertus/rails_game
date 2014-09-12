class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if (params[:user][:password] == params[:user][:confirm_password]) && (@user.save)
      sign_up_mail(@user)
      redirect_to games_path, :notice => "User successfully Added"
    else
      render :action => "new"
    end
  end
  
  def edit
    @user = current_user 
  end
  
  def update 
    @user = current_user
    if @user.update_attribute(params[:user])
      redirect_to games_path, :notice => "Updated user information successfully"
    else
      render :action => "edit"
    end
  end
  
  def sign_up_mail(user)
    @user = user
    Notifier.sign_up_mail(@user).deliver
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
  
end

