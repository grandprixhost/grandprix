class Toernooi < ApplicationRecord
  validates :naam, :wedstrijdleider, :datum, presence: true

  has_many :groeps, :dependent => :destroy
  has_many :partijs, through: :groeps
  has_and_belongs_to_many :deelnemers
end