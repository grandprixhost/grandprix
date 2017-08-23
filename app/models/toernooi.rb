class Toernooi < ApplicationRecord
  has_many :groeps
  has_many :partijen, through: :groeps
  has_and_belongs_to_many :deelnemers
end
