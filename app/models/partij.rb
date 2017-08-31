class Partij < ApplicationRecord
  belongs_to :groep
  delegate :toernooi, :to => :groep
  belongs_to :witspeler, foreign_key: 'witspeler_id', class_name: "Deelnemer"
  belongs_to :zwartspeler, foreign_key: 'zwartspeler_id', class_name: "Deelnemer"
end
