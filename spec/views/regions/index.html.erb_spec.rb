require 'rails_helper'

RSpec.describe 'regions/index' do
  it 'displays all the regions' do
    country = Country.all.first
    assign(:regions, [
             Region.create!(name: 'first region', country: country),
             Region.create!(name: 'second region', country: country)
           ])
    render

    expect(rendered).to match /first region/
    expect(rendered).to match /second region/
  end

  it 'displays header with country name if presents' do
    country = Country.create!(name: 'country name')
    assign(:regions, [
             Region.create!(name: 'first region', country: country)
           ])
    assign(:country, country)

    render

    expect(rendered).to match /country name/
  end
end