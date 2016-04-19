class VotesController < ApplicationController
  def create
    Gif.find(params[:gif_id]).votes.create(user: current_user)
    format.html {
      flash[:success] = "We hear you, that's nifty!"
      redirect_to :root
    }
    format.js {}
  end

  private

  def has_voted?
  end
end
