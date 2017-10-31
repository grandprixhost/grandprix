class Partij < ApplicationRecord
  belongs_to :groep
  delegate :toernooi, :to => :groep
  belongs_to :witspeler, foreign_key: 'witspeler_id', class_name: "Deelnemer"
  belongs_to :zwartspeler, foreign_key: 'zwartspeler_id', class_name: "Deelnemer"

  def pts
    if ["1", "1-0", "+"].include?(uitslag)
      return 1
    elsif ["=", "1/2-1/2"].include?(uitslag)
      return 0.5
    elsif ["0", "0-1", "-"].include?(uitslag)
      return 0
    end
  end

end
