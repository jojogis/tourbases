require 'rails_helper'

RSpec.describe 'tour_bases/index' do
  it 'displays all the tour bases' do
    region = Region.all.first
    assign(:tour_bases, [
             TourBase.create!(name: 'first tour base', region: region),
             TourBase.create!(name: 'second tour base', region: region)
           ])
    render

    expect(rendered).to match /first tour base/
    expect(rendered).to match /second tour base/
  end

  it 'displays header with region name if presents' do
    region = Region.create!(name: 'region name', country: Country.all.first)
    assign(:tour_bases, [
             TourBase.create!(name: 'tour base', region: region)
           ])
    assign(:region, region)

    render

    expect(rendered).to match /region name/
  end

  it 'displays header with city name if presents' do
    region = Region.create!(name: 'region name', country: Country.all.first)
    city = City.create!(name: 'city name', region: region)
    assign(:tour_bases, [
             TourBase.create!(name: 'tour base', region: region)
           ])
    assign(:city, city)

    render

    expect(rendered).to match /city name/
  end
  it 'displays header with country name if presents' do
    country = Country.create!(name: 'country name')
    region = Region.create!(name: 'region name', country: country)
    assign(:tour_bases, [
             TourBase.create!(name: 'tour base', region: region)
           ])
    assign(:country, country)

    render

    expect(rendered).to match /country name/
  end
end