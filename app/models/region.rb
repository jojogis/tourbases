class Region < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  belongs_to :country
end
