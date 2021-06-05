class Region < ApplicationRecord
  has_many :cities
  validates :name, presence: true, length: { minimum: 2 }
  belongs_to :country
  accepts_nested_attributes_for :cities
end
