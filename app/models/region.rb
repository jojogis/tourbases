class Region < ApplicationRecord
  has_many :cities
  has_many :tour_base
  validates :name, presence: true, length: { minimum: 2 }
  belongs_to :country
  accepts_nested_attributes_for :cities, :tour_base
end
