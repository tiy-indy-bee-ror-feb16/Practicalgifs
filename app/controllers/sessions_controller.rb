class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:id].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Welcome to Nifty Gifs!"
      session[:user_id] = user.id
      redirect_to :root
    else
      flash[:danger] = "That email/password combination isn't Nifty"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Stay Nifty"
    redirect_to :root
  end
end
