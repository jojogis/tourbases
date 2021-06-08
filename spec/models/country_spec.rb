require 'rails_helper'

RSpec.describe Country, type: :model do
  context 'creating' do
    it 'has empty name' do
      country = Country.new
      expect(country.save).to eq false
    end

    it 'has name with one symbol' do
      country = Country.new({ name: 'a' })
      expect(country.save).to eq false
    end

    it 'created' do
      country = Country.new({ name: 'abc' })
      expect(country.save).to eq true
    end
  end
  context 'destroying' do
    it 'was destroyed' do
      country = Country.all.first
      country_id = country.id
      country.destroy
      expect(Country.find_by(id: country_id).nil?).to eq true
    end
    it 'was destroyed and associated region was deleted' do
      country = Country.all.first
      region = Region.new({ name: 'test', country: country })
      region.save
      region_id = region.id
      expect(Region.find_by(id: region_id).nil?).to eq false
      country.destroy
      expect(Region.find_by(id: region_id).nil?).to eq true
    end
  end
end
