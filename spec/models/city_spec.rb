require 'rails_helper'

RSpec.describe City, type: :model do
  context 'creating' do
    it 'has empty name' do
      region = Region.all.first
      city = City.new({ region: region })
      expect(city.save).to eq false
    end

    it 'has name with one symbol' do
      region = Region.all.first
      city = City.new({ region: region, name: 'a' })
      expect(city.save).to eq false
    end

    it 'has not region' do
      city = City.new({ region: nil, name: 'abc' })
      expect(city.save).to eq false
    end

    it 'created' do
      region = Region.all.first
      city = City.new({ region: region, name: 'abc' })
      expect(city.save).to eq true
    end
  end
  context 'destroying' do
    it 'was destroyed' do
      city = City.all.first
      city_id = city.id
      city.destroy
      expect(City.find_by(id: city_id).nil?).to eq true
    end
    it 'was destroyed and tour bases association was set to nil' do
      city = City.all.first
      region = Region.all.first
      tour_base = TourBase.new({ name: 'test', region: region, city: city })
      tour_base.save
      tour_base_id = tour_base.id
      expect(TourBase.find(tour_base_id).city.nil?).to eq false
      city.destroy
      expect(TourBase.find(tour_base_id).city.nil?).to eq true
    end
  end
end
