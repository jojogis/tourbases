require 'rails_helper'

RSpec.describe 'cities/index' do
  it 'displays all the cities' do
    region = Region.all.first
    assign(:cities, [
             City.create!(name: 'first city', region: region),
             City.create!(name: 'second city', region: region)
           ])
    render

    expect(rendered).to match /first city/
    expect(rendered).to match /second city/
  end

  it 'displays header with country name if presents' do
    region = Region.create!(name: 'region name', country: Country.all.first)
    assign(:cities, [
             City.create!(name: 'city', region: region)
           ])
    assign(:region, region)

    render

    expect(rendered).to match /region name/
  end
end