class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to :root
      respond_to do |format|
        format.html {
          flash[:success] = "Welcome to Nifty Gifs!"
          redirect_to :root
        }
        format.js { }
      end
    else
      flash[:danger] = "That email/password combination isn't Nifty"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html {
        flash[:success] = "Stay Nifty"
        redirect_to :root
      }
      format.js { render :action => "new_modal" }
    end
  end
end
