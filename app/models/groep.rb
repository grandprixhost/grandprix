class Groep < ApplicationRecord
  validates :nummer, presence: true

  belongs_to :toernooi
  has_many :partijs
  has_and_belongs_to_many :deelnemers
end
