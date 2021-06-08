require 'rails_helper'

RSpec.describe 'countries/index' do
  it 'displays all the countries' do
    assign(:countries, [
             Country.create!(name: 'first country'),
             Country.create!(name: 'second country')
           ])
    render

    expect(rendered).to match /first country/
    expect(rendered).to match /second country/
  end
end