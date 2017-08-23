class Deelnemer < ApplicationRecord
  has_and_belongs_to_many :toernoois
  has_and_belongs_to_many :groeps
end
