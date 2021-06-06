class View::TourBasesController < ApplicationController

  def index
    @tour_bases = TourBase.all
    unless params[:country_id].nil?
      @country = Country.find(params[:country_id])
      @tour_bases = @country.tour_base
    end
    unless params[:region_id].nil?
      @region = Region.find(params[:region_id])
      @tour_bases = @region.tour_base
    end
    unless params[:city_id].nil?
      @city = City.find(params[:city_id])
      @tour_bases = @city.tour_base
    end

    @countries = Country.all
    @regions = @country.nil? ? Region.all : @country.regions
    @cities = @region.nil? ? City.all : @region.cities
  end

end
