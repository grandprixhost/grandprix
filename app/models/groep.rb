class Groep < ApplicationRecord
  validates :nummer, presence: true

  belongs_to :toernooi
  has_many :partijs, :dependent => :destroy
  has_and_belongs_to_many :deelnemers

  def indeling
    deelnemerscopy = deelnemers.to_a.collect { |deelnemer| deelnemer.id }
    odd = deelnemerscopy.length.odd?
    deelnemerscopy << 1 if odd #1 is the ID of the bye deelnemer
    n = deelnemerscopy.length
    indeling = []

    (n-1).times do |r| 
      indeling << []
      spelers = (1..(n-1)).to_a
      op = r.even? ? (r+2)/2 : (r+n+1)/2
      spelers.delete(op)
      indeling[r] << [deelnemerscopy[op-1], deelnemerscopy[n-1]]
      indeling[r].last.reverse! unless odd || r.even?
      until spelers.empty? 
        pl = spelers.pop
        op = (r+n+1-pl) % (n-1)
        spelers.delete(op)
        indeling[r] << [deelnemerscopy[op-1], deelnemerscopy[pl-1]] 
        indeling[r].last.reverse! unless (pl+op).even? ^ (pl>op)
      end
    end
    return indeling
  end

  def tussenstand
    score = {}
    deelnemers.each { |deelnemer| score[deelnemer.id]=0 }
    partijs.each do |partij| 
      if partij.uitslag == "1-0"||partij.uitslag == "1"||partij.uitslag=="+"
        score[partij.witspeler_id] += 1
      elsif partij.uitslag == "1/2-1/2"||partij.uitslag == "=" 
        score[partij.witspeler_id] += 0.5
        score[partij.zwartspeler_id] += 0.5 unless partij.zwartspeler_id == 1 #No points to BYE deelnemer
      elsif partij.uitslag == "0-1"|| partij.uitslag == "0"||partij.uitslag=="-"
        score[partij.zwartspeler_id] += 1 unless partij.zwartspeler_id == 1 #No points to BYE deelnemer
      end
    end
    score.to_a.sort { |x,y| x[1] <=> y[1] }.reverse
  end

end
