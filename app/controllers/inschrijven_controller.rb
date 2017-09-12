class InschrijvenController < ApplicationController
  def new
    @toernooi = Toernooi.find(params[:id])
    @deelnemer = Deelnemer.new
    @controller = "inschrijven"
  end
  def create
    @toernooi = Toernooi.find(params[:toernooi_id])

    @deelnemer = Deelnemer.find_by(deelnemer_params) || Deelnemer.new(deelnemer_params)
    @deelnemer.email = params[:deelnemer][:email] || ""
    @deelnemer.telefoonnummer = params[:deelnemer][:telefoonnummer] || ""
    @deelnemer.knsbnummer = params[:deelnemer][:knsbnummer].to_i || 0
    @deelnemer.rating = params[:deelnemer][:rating].to_i || 0
    @deelnemer.tussenvoegsel ||= ""
    unless @deelnemer.valid? || @deelnemer.save then
      render :action => :new
      return ""
    end

    @dzg = @toernooi.groeps.find_by(nummer: 0)
    @dzg.deelnemers.push(@deelnemer) unless @toernooi.deelnemers.exists?(@deelnemer.id) 
    @toernooi.deelnemers.push(@deelnemer) unless @toernooi.deelnemers.exists?(@deelnemer.id)
    redirect_to @toernooi
  end
  def destroy
    #@toernooi = Toernooi.find(params[:toernooi_id])
    @deelnemer = Deelnemer.find(params[:deelnemer_id])
    @deelnemer.toernoois.delete(params[:toernooi_id])
    @deelnemer.groeps.delete(Groep.find_by(toernooi_id: params[:toernooi_id]))
    #@toernooi.deelnemers.delete(params[:deelnemer_id])

    redirect_to toernooi_path(params[:toernooi_id])
  end

  private 

    def deelnemer_params
      params.require(:deelnemer).permit(:voornaam, :achternaam, :tussenvoegsel, :geboortedatum)
    end

end
