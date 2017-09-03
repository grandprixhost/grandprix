class InschrijvenController < ApplicationController
  def new
    @toernooi = Toernooi.find(params[:id])
    @deelnemer = Deelnemer.new
  end
  def create
    @toernooi = Toernooi.find(params[:toernooi_id])
    @deelnemer = Deelnemer.new(deelnemer_params)
    render :action => :new unless @deelnemer.valid?
    @deelnemer = Deelnemer.find_or_create_by(deelnemer_params)
    @deelnemer.tussenvoegsel ||= ""
    @toernooi.deelnemers.push(@deelnemer) unless @toernooi.deelnemers.exists?(@deelnemer.id)
    @dzg = @toernooi.groeps.find_by(nummer: 0)
    @dzg.deelnemers.push(@deelnemer) unless @dzg.deelnemers.exists?(@deelnemer.id)
    redirect_to @toernooi
  end
  def destroy
    @toernooi = Toernooi.find(params[:toernooi_id])
    @toernooi.deelnemers.delete(params[:deelnemer_id])
    redirect_to @toernooi
  end

  private 

    def deelnemer_params
      params.require(:deelnemer).permit(:voornaam, :achternaam, :tussenvoegsel, :geboortedatum)
    end

end
