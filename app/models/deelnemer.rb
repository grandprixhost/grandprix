class Deelnemer < ApplicationRecord
  validates :voornaam, :achternaam, :geboortedatum, presence: true

  has_and_belongs_to_many :toernoois
  has_and_belongs_to_many :groeps

  has_many :partijs, foreign_key: "witspeler_id" 
  has_many :partijs, foreign_key: "zwartspeler_id"

  def naam
    "#{voornaam} #{tussenvoegsel + ' ' unless tussenvoegsel.empty?}#{achternaam}"
  end

end
