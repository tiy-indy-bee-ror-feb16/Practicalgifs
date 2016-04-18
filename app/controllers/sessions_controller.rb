class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
          format.html {
            flash[:success] = "Welcome to Nifty Gifs!"
            redirect_to :root
          }
          format.js {}
      else
        flash[:danger] = "That email/password combination isn't Nifty"
        format.html { render :new }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html {
        flash[:success] = "Stay Nifty"
        redirect_to :root
      }
      format.js {}
    end
  end
end
