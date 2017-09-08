class IndelenController < ApplicationController
  
  bye_id = 1

  def show 

    #Round Robin

    @toernooi = Toernooi.find(params[:toernooiid])
    @groep = @toernooi.groeps.find_by(nummer: params[:groepnummer])
    @deelnemers = @groep.deelnemers

    @indeling = []
    deelnemerscopy = @deelnemers.to_a
    deelnemerscopy << Deelnemer.find(bye_id) if deelnemerscopy.length.odd? #59 is the id of the BYE deelnemer.
    n = deelnemerscopy.length
    (n-1).times do |r| #r = ronde
      @indeling << []
      spelers = (1..(n-1)).to_a
      op = r.even? ? (r+2)/2 : (r+n+1)/2 
      spelers.delete(op)
      @indeling[r].push([deelnemerscopy[op-1], deelnemerscopy.last])
      prt = Partij.find_or_create_by(groep_id: @groep.id, witspeler_id: deelnemerscopy[op-1].id, zwartspeler_id: deelnemerscopy.last.id)
      prt.uitslag ||= "1-0"
      prt.save

      until spelers.empty?
        pl = spelers.pop
        op = (r+n+1-pl) % (n-1)
        spelers.delete(op)
        @indeling[r].push( (pl+op).even? ^ (pl>op) ? [deelnemerscopy[op-1], deelnemerscopy[pl-1]] : [deelnemerscopy[pl-1], deelnemerscopy[op-1]] )
      end

    end

    #Score Bijhouden

    score = {}
    @deelnemers.each do |deelnemer|
      score[deelnemer.id] = 0
    end
    @groep.partijs.each do |partij|
      if partij.uitslag == "1-0"
        score[partij.witspeler_id] += 1
      elsif partij.uitslag == "1/2-1/2" 
        score[partij.witspeler_id] += 0.5
        score[partij.zwartspeler_id] += 0.5 unless partij.zwartspeler_id == bye_id #No points to BYE player
      else
        score[partij.zwartspeler_id] += 1 unless partij.zwartspeler_id == bye_id #No points to BYE player
      end
    end
    @score = score.sort_by { |deelnemerid, score| -score }

  end

  def index
    @toernooi = Toernooi.find(params[:toernooiid])
  end

  def addingroep
    @toernooi = Toernooi.find(params[:toernooiid])
    @deelnemer = Deelnemer.find(params[:deelnemerid])
    @groep = @toernooi.groeps.find_or_create_by(nummer: params[:nummer],toernooi_id: @toernooi.id)
    @toernooi.groeps.each do |groep|
      groep.deelnemers.delete(@deelnemer.id) if groep.deelnemers.exists?(@deelnemer.id)
    end
    @groep.deelnemers << @deelnemer

    render :action => "index"
  end

  def invoeren
    uitslag = params[:resultaat].chomp
    @groep = Groep.find(params[:groep_id])
    @partij = Partij.find_or_create_by(witspeler_id: params[:witspeler_id], zwartspeler_id: params[:zwartspeler_id], groep_id: params[:groep_id] )
    @partij.uitslag = uitslag
    @partij.save
    flash[:notice] = "Resultaat succesvol ingevoerd!\n#{Deelnemer.find(params[:witspeler_id]).naam}-#{Deelnemer.find(params[:zwartspeler_id]).naam}\t#{uitslag}"
    redirect_to "/indelen/#{@groep.toernooi_id}/#{@groep.nummer}"
  end

end
