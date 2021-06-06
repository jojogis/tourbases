class TourBase < ApplicationRecord
  belongs_to :city, optional: true
  belongs_to :region
  validates :name, presence: true, length: { minimum: 2 }

end
