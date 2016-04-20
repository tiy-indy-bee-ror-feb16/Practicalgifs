class GifsController < ApplicationController
  before_action :set_gif, only: [:show, :destroy]
  before_filter :require_user, only: [:new, :create, :destroy]

  def index
    @gifs = Gif.order("created_at DESC").page(params[:page]).per(20)

    if current_user
      @user = current_user
      @gif = Gif.new
    end
  end

  def new
    @gif = current_user.gifs.new
  end

  def create
    @gif = current_user.gifs.create(gif_params)
    respond_to do |format|
      if @gif.save
        format.html { redirect_to root_path, notice: 'gif was successfully created.' }
        format.js {}
      else
        format.html { render :new }
        format.js {}
      end
    end
  end

  def show
    @user = User.find(params[:user_id])
    @gif = Gif.find(params[:id])
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def destroy
    @user = current_user
    @gif.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Gif was successfully destroyed.' }
      format.js {}
    end
  end

  private

  def set_gif
    @gif = Gif.find(params[:id])
  end

  def gif_params
    params.require(:gif).permit(:gif_image, :url)
  end

end
