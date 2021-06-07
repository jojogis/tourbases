class TourBasesController < ApplicationController

  def index
    @tour_bases = if !params[:region_id].nil?
                    @region = Region.find(params[:region_id])
                    @region.tour_base
                  elsif !params[:city_id].nil?
                    @city = City.find(params[:city_id])
                    @city.tour_base
                  elsif !params[:country_id].nil?
                    @country = Country.find(params[:country_id])
                    @country.tour_base
                  else
                    TourBase.all
                  end
  end

  def new
    @tour_base = TourBase.new
  end

  def create
    @tour_base = TourBase.new(tour_base_params)
    if @tour_base.save
      redirect_to action: :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tour_base = TourBase.find(params[:id])
  end

  def update
    @tour_base = TourBase.find(params[:id])
    if @tour_base.update(tour_base_params)
      redirect_to action: :index
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tour_base = TourBase.find(params[:id])
    @tour_base.destroy
    redirect_back fallback_location: :index
  end

  private

  def tour_base_params
    params.require(:tour_base).permit(:name, :city_id, :region_id,:description)
  end

end
