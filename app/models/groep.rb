class Groep < ApplicationRecord
  belongs_to :toernooi
  has_many :partijs
  has_and_belongs_to_many :deelnemers
end
