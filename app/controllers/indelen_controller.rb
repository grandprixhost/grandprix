class IndelenController < ApplicationController

  def show 

    #Round Robin

    @toernooi = Toernooi.find(params[:toernooiid])
    @groep = @toernooi.groeps.find_by(nummer: params[:groepnummer])
    @deelnemers = @groep.deelnemers

    @indeling = []

    @score = @groep.tussenstand

  end

  def index
    @toernooi = Toernooi.find(params[:toernooiid])
    @groeps = @toernooi.groeps.order("nummer").all
  end

  def addingroep
    @toernooi = Toernooi.find(params[:toernooiid])
    @groeps = @toernooi.groeps.order("nummer").all
    @deelnemer = Deelnemer.find(params[:deelnemerid])
    @groep = @toernooi.groeps.find_or_create_by(nummer: params[:nummer],toernooi_id: @toernooi.id)
    @toernooi.groeps.each { |groep| groep.deelnemers.delete(@deelnemer.id) if groep.deelnemers.exists?(@deelnemer.id) }
    @groep.deelnemers << @deelnemer
    @toernooi.groeps.each { |groep| groep.delete if groep.deelnemers.empty? && groep.nummer != 0 }

    render "index"
  end

  def invoeren
    uitslag = params[:resultaat].chomp
    @groep = Groep.find(params[:groep_id])
    @partij = Partij.find_or_create_by(witspeler_id: params[:witspeler_id], zwartspeler_id: params[:zwartspeler_id], groep_id: params[:groep_id] )
    @partij.uitslag = uitslag
    @partij.ronde = params[:ronde]
    @partij.save
    @partij.delete if uitslag == ""
    flash[:notice] = "Resultaat succesvol ingevoerd!\n#{Deelnemer.find(params[:witspeler_id]).naam}-#{Deelnemer.find(params[:zwartspeler_id]).naam}\t#{uitslag}"
    #redirect_to "/indelen/#{@groep.toernooi_id}/score"
  end

  def score
    @toernooi = Toernooi.find(params[:toernooiid])
    @indelings = []
    @groeps = @toernooi.groeps.order("nummer").all
    @groeps.each do |groep|
      next if groep.nummer == 0

      @indelings[groep.nummer] = groep.indeling
    end
    @rondes = params[:ronde].nil? ? (0..23) : (params[:ronde].to_i-1..params[:ronde].to_i-1)
  end

  def uitslag
    @toernooi = Toernooi.find(params[:toernooiid])
    @groeps = @toernooi.groeps.order("nummer").all
  end

  def print
    @toernooi = Toernooi.find(params[:toernooiid])
    @indelings = []
    @toernooi.groeps.each do |groep|
      next if groep.nummer == 0

      @indelings[groep.nummer] = groep.indeling
      
    end
  end

end
