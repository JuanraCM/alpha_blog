class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      flash[:success] = "You have sucessfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "The credentials you have entered are wrong"
      render 'new'
    end
  end

  def destroy
    debugger
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end