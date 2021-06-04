class Country < ApplicationRecord
  has_many :regions
  validates :name, presence: true, length: { minimum: 2 }
end
