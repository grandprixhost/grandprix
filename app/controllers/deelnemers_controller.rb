class DeelnemersController < ApplicationController

  def index
    @deelnemers = Deelnemer.all
  end

  def show
    @deelnemer = Deelnemer.find(params[:id])
  end

  def new
    @deelnemer = Deelnemer.new
  end
  def create
    deelnemer_params[:tussenvoegsel] ||= ""
    @deelnemer = Deelnemer.new(deelnemer_params)
    if Deelnemer.find_by(deelnemer_params) || @deelnemer.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def destroy
    @deelnemer = Deelnemer.find(params[:id])
    @deelnemer.destroy
    redirect_to :action => "index"
  end

  private 

    def deelnemer_params
      params.require(:deelnemer).permit(:voornaam, :achternaam, :tussenvoegsel, :geboortedatum)
    end

end
