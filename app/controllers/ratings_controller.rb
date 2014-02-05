class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    if current_user.nil?
      redirect_to signin_path, notice: 'You have to be signed in to rate a beer'
      return
    end
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    if @rating.save
      current_user.ratings << @rating
      redirect_to ratings_path
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
  
end