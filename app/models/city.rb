class City < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  belongs_to :region
  has_many :tour_base
  accepts_nested_attributes_for :tour_base
end
