class AanmeldenController < ApplicationController

  def index
    @toernoois = Toernooi.all
  end

  def new
    @toernooi = Toernooi.find(params[:id])
    @deelnemer = Deelnemer.new
  end

  def create
    @toernooi = Toernooi.find(params[:toernooi_id])
    @deelnemer = Deelnemer.find_by(deelnemer_params) || Deelnemer.new(deelnemer_params)
    @deelnemer.tussenvoegsel ||= ""
    render :action => :new unless @deelnemer.save
#    @deelnemer = Deelnemer.find_or_create_by(deelnemer_params)
    @dzg = @toernooi.groeps.find_by(nummer: 0)
    @dzg.deelnemers.push(@deelnemer) unless @toernooi.deelnemers.exists?(@deelnemer.id)
    @toernooi.deelnemers.push(@deelnemer) unless @toernooi.deelnemers.exists?(@deelnemer.id)
    redirect_to "/thx"
  end

  def thx

  end

  private

    def deelnemer_params
      params.require(:deelnemer).permit(:voornaam, :achternaam, :tussenvoegsel, :geboortedatum)
    end

end
