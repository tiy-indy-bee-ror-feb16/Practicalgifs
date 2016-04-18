class UsersController < ApplicationController
  before_action :disallow_user, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      respond_to do |format|
        format.html {
          redirect_to {@user}
          flash[:success] = "You're ready to nifty your life!"
        }
        format.js { }
      end
    else
      format.html { render :new }
    end
  end

  def show
    @user = User.find(params[:id])
    @gifs = @user.gifs.page(params[:page])
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
