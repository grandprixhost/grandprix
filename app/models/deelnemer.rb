class Deelnemer < ApplicationRecord
  validates :voornaam, :achternaam, :geboortedatum, presence: true

  has_and_belongs_to_many :toernoois
  has_and_belongs_to_many :groeps

  has_many :partijs, foreign_key: "witspeler_id", dependent: :destroy
  has_many :partijs, foreign_key: "zwartspeler_id", dependent: :destroy

  def naam
    "#{voornaam} #{tussenvoegsel + ' ' unless tussenvoegsel.empty?}#{achternaam}"
  end

  def effrating
    rating.nil?||rating.zero? ? 100 + (Time.now.year - geboortedatum.year) : rating
  end

end
