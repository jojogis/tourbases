class Country < ApplicationRecord
  has_many :regions
  has_many :tour_base, through: :regions
  validates :name, presence: true, length: { minimum: 2 }
  accepts_nested_attributes_for :regions
end
