class RegionsController < ApplicationController

  def index
    @regions = if params[:country_id].nil?
                 Region.all
               else
                 Country.find(params[:country_id]).regions
               end

  end

  def new
    @country = Country.find(params[:country_id]) unless params[:country_id].nil?
    @region = Region.new
  end

  def create
    @region = Region.new(region_params)
    if @region.save
      redirect_to action: :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @region = Region.find(params[:id])
  end

  def update
    @region = Region.find(params[:id])
    if @region.update(region_params)
      redirect_to action: :index
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @region = Region.find(params[:id])
    @region.destroy
    redirect_to action: :index
  end

  private

  def region_params
    params.require(:region).permit(:name,:country_id)

  end
end
