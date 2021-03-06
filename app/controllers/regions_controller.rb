class RegionsController < ApplicationController

  def index
    @regions = if params[:country_id].nil?
                 Region.all
               else
                 @country = Country.find(params[:country_id])
                 @country.regions
               end
    @regions.each do |region|
      next if region.cities.length.zero?

      cities_list = region.cities.reduce('') { |list, c| "#{list}#{c.name}, " }
      cities_list.chomp!(', ')
      region.delete_confirm = "Будут удалены следующие города: #{cities_list}"
    end

  end

  def new
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
    redirect_back fallback_location: regions_path
  end

  private

  def region_params
    params.require(:region).permit(:name, :country_id)
  end
end
