class Country < ApplicationRecord
  has_many :regions, dependent: :destroy
  has_many :tour_base, through: :regions
  validates :name, presence: true, length: { minimum: 2 }
  accepts_nested_attributes_for :regions
  attr_accessor :delete_confirm
end
