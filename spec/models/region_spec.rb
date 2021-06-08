require 'rails_helper'

RSpec.describe Region, type: :model do
  context 'creating' do
    it 'has empty name' do
      country = Country.all.first
      region = Region.new({ country: country })
      expect(region.save).to eq false
    end

    it 'has name with one symbol' do
      country = Country.all.first
      region = Region.new({ country: country, name: 'a' })
      expect(region.save).to eq false
    end

    it 'has not region' do
      region = Region.new({ country: nil, name: 'abc' })
      expect(region.save).to eq false
    end

    it 'created' do
      country = Country.all.first
      region = Region.new({ country: country, name: 'abc' })
      expect(region.save).to eq true
    end
  end
  context 'destroying' do
    it 'was destroyed' do
      region = Region.all.first
      region_id = region.id
      region.destroy
      expect(Region.find_by(id: region_id).nil?).to eq true
    end
    it 'was destroyed and associated city was deleted' do
      region = Region.all.first
      city = City.new({ name: 'test', region: region })
      city.save
      city_id = city.id
      expect(City.find_by(id: city_id).nil?).to eq false
      region.destroy
      expect(City.find_by(id: city_id).nil?).to eq true
    end
    it 'was destroyed and associated tour base was deleted' do
      region = Region.all.first
      tour_base = TourBase.new({ name: 'test', region: region })
      tour_base.save
      tour_base_id = tour_base.id
      expect(TourBase.find_by(id: tour_base_id).nil?).to eq false
      region.destroy
      expect(TourBase.find_by(id: tour_base_id).nil?).to eq true
    end
  end
end
