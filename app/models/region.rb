class Region < ApplicationRecord
  has_many :cities, dependent: :destroy
  has_many :tour_base, dependent: :destroy
  validates :name, presence: true, length: { minimum: 2 }
  belongs_to :country
  accepts_nested_attributes_for :cities, :tour_base
end
