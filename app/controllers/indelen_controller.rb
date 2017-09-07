class IndelenController < ApplicationController
  
  def show #Round Robin

    @toernooi = Toernooi.find(params[:toernooiid])
    @groep = @toernooi.groeps.find_by(nummer: params[:groepnummer])
    @deelnemers = @groep.deelnemers

    @indeling = []
    deelnemerscopy = @deelnemers.to_a
    deelnemerscopy << Deelnemer.find(46) #Id of the BYE deelnemer
    n = deelnemerscopy.length
    (n-1).times do |r| #r = ronde
      @indeling << []
      spelers = (1..(n-1)).to_a
      op = r.even? ? (r+2)/2 : (r+n+1)/2 
      spelers.delete(op)
      @indeling[r].push([deelnemerscopy[op-1], deelnemerscopy.last])
      prt = Partij.find_or_create_by(groep_id: @groep.id, witspeler_id: deelnemerscopy[op-1].id, zwartspeler_id: deelnemerscopy.last.id)
      prt.uitslag ||= "1-0"

      until spelers.empty?
        pl = spelers.pop
        op = (r+n+1-pl) % (n-1)
        spelers.delete(op)
        @indeling[r].push( (pl+op).even? ^ (pl>op) ? [deelnemerscopy[op-1], deelnemerscopy[pl-1]] : [deelnemerscopy[pl-1], deelnemerscopy[op-1]] )
      end

    end

  end

  def index
    @toernooi = Toernooi.find(params[:toernooiid])
  end

  def addingroep
    @toernooi = Toernooi.find(params[:toernooiid])
    @deelnemer = Deelnemer.find(params[:deelnemerid])
    @groep = @toernooi.groeps.find_or_create_by(nummer: params[:groep][:nummer],toernooi_id: @toernooi.id)
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
