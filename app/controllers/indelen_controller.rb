class IndelenController < ApplicationController
  
  def show #Round Robin
    
    @toernooi = Toernooi.find(params[:toernooiid])
    @groep = @toernooi.groeps.find_by(nummer: params[:groepnummer])
    @deelnemers = @groep.deelnemers

    @indeling = []
    deelnemerscopy = @deelnemers.to_a
    deelnemerscopy << Deelnemer.new(voornaam:"Bye", tussenvoegsel:"", achternaam:"", geboortedatum:"0001-01-01") if deelnemerscopy.length.odd?
    n = deelnemerscopy.length
    (n-1).times do |r| #r = ronde
      @indeling << []
      spelers = (1..(n-1)).to_a
      op = r.even? ? (r+2)/2 : (r+n+1)/2 
      spelers.delete(op)
      @indeling[r].push([deelnemerscopy[op-1], deelnemerscopy.last])

      until spelers.empty?
        pl = spelers.pop
        op = (r+n+1-pl) % (n-1)
        spelers.delete(op)
        @indeling[r].push( (pl+op).even? ^ (pl>op) ? [deelnemerscopy[op-1], deelnemerscopy[pl-1]] : [deelnemerscopy[pl-1], deelnemerscopy[op-1]] )
      end

    end


    render :action => "show"

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

  #private

end
