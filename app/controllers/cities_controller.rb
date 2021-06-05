class CitiesController < ApplicationController

  def index
    @cities = if params[:region_id].nil?
                City.all
              else
                @region = Region.find(params[:region_id])
                @region.cities
              end
  end

  def new
    @region = Region.find(params[:region_id]) unless params[:region_id].nil?
    @city = City.new
  end

  def create
    @city = City.new(city_params)
    if @city.save
      redirect_to action: :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @city = City.find(params[:id])
  end

  def update
    @city = City.find(params[:id])
    if @city.update(city_params)
      redirect_to action: :index
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @city = City.find(params[:id])
    @city.destroy
    redirect_to action: :index
  end

  private

  def city_params
    params.require(:city).permit(:name, :region_id)
  end
end
