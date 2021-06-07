class CountriesController < ApplicationController

  def index
    @countries = Country.all
    @countries.each do |country|
      next if country.regions.length.zero?

      regions_list = country.regions.reduce('') { |list, r| "#{list}#{r.name}, " }
      regions_list.chomp!(', ')
      country.delete_confirm = "Будут удалены следующие регионы: #{regions_list}"
    end
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)
    if @country.save
      redirect_to action: :index
    else
      render :new, status: :unprocessable_entity
    end

  end

  def destroy
    @country = Country.find(params[:id])
    @country.destroy
    redirect_to action: :index
  end

  def edit
    @country = Country.find(params[:id])
  end

  def update
    @country = Country.find(params[:id])
    if @country.update(country_params)
      redirect_to action: :index
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  
  def country_params
    params.require(:country).permit(:name)
  end
end






