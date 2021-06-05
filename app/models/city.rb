class City < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  belongs_to :region
end
