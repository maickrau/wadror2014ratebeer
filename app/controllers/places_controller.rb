class PlacesController < ApplicationController
  def index
  end

  def show
    places = BeermappingApi.places_in(params[:city])
    @place = places.select { |place| place.id == params[:id] }.first
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
    @city = params[:city]
  end
end