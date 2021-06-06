
3.times do
  country = Country.create(name: Faker::Address.country)
  3.times do
    region = Region.create(name: Faker::Address.state, country: country)
    3.times do
      city = City.create(name: Faker::Address.city, region: region)
      3.times do
        r = Faker::Restaurant
        TourBase.create(name: r.name, description: r.description,city: city, region: region)
      end
    end

    r = Faker::Restaurant
    TourBase.create(name: r.name, description: r.description,city: nil, region: region)

  end
end