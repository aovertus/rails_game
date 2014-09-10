class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if (params[:user][:password] == params[:user][:confirm_password]) && (@user.save)
      redirect_to games_path, :notice => "User successfully Added"
    else
      render :action => "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update 
    @user = User.find(params[:id])
    if @user.update_attribute(params[:user])
      redirect_to games_path, :notice => "Updated user information successfully"
    else
      render :action => "edit"
    end
  end
  
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
end

