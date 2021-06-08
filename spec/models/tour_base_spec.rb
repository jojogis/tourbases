require 'rails_helper'

RSpec.describe TourBase, type: :model do
  context 'creating' do
    it 'has empty name' do
      region = Region.all.first
      tour_base = TourBase.new({ region: region })
      expect(tour_base.save).to eq false
    end

    it 'has name with one symbol' do
      region = Region.all.first
      tour_base = TourBase.new({ region: region, name: 'a' })
      expect(tour_base.save).to eq false
    end

    it 'has not region' do
      tour_base = TourBase.new({ region: nil, name: 'abc' })
      expect(tour_base.save).to eq false
    end

    it 'created without city' do
      region = Region.all.first
      tour_base = TourBase.new({ region: region, name: 'abc' })
      expect(tour_base.save).to eq true
    end

    it 'created with city' do
      region = Region.all.first
      city = City.all.first
      tour_base = TourBase.new({ region: region, name: 'abc', city: city })
      expect(tour_base.save).to eq true
    end
  end
  context 'destroying' do
    it 'was destroyed' do
      tour_base = TourBase.all.first
      tour_base_id = tour_base.id
      tour_base.destroy
      expect(TourBase.find_by(id: tour_base_id).nil?).to eq true
    end
  end
end
