class Deelnemer < ApplicationRecord
  validates :voornaam, :achternaam, :geboortedatum, presence: true

  has_and_belongs_to_many :toernoois
  has_and_belongs_to_many :groeps
end
