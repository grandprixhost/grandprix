class Toernooi < ApplicationRecord
  validates :naam, :wedstrijdleider, :datum, presence: true

  has_many :groeps
  has_many :partijen, through: :groeps
  has_and_belongs_to_many :deelnemers
end
