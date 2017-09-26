class DeelnemersController < ApplicationController

  def index
    @deelnemers = Deelnemer.all
    @url = deelnemers_path
  end

  def show
    @deelnemer = Deelnemer.find(params[:id])
  end

  def new
    @deelnemer = Deelnemer.new
  end

  def create
    #Code copied in: inschrijven_controller.rb
    #Code copied in: aanmelden_controller.rb
    @deelnemer = Deelnemer.find_by(deelnemer_ess_params) || Deelnemer.new(deelnemer_params)
    
    @deelnemer.tussenvoegsel ||= ""
    @deelnemer.telefoonnummer ||= ""
    @deelnemer.knsbnummer ||= 0
    @deelnemer.rating ||= 0

    @deelnemer.email = params[:deelnemer][:email]
    @deelnemer.telefoonnummer = params[:deelnemer][:telefoonnummer]
    @deelnemer.knsbnummer = params[:deelnemer][:knsbnummer]
    @deelnemer.rating = params[:deelnemer][:rating]    
    
    if @deelnemer.save
      redirect_to deelnemers_path
    else
      render 'new'
    end

  end

  def edit
    @deelnemer = Deelnemer.find(params[:id])
  end

  def update
    @deelnemer = Deelnemer.find(params[:id])
    
    params[:deelnemer][:tussenvoegsel] ||= ""
    params[:deelnemer][:telefoonnummer] ||= ""
    params[:deelnemer][:telefoonnummer] ||= 0
    params[:deelnemer][:rating] ||= 0
    
    @deelnemer.update_attributes(deelnemer_params)
    if @deelnemer.save
      redirect_to :action => "index"
    else
      render :action => "edit"
    end

  end

  def destroy
    @deelnemer = Deelnemer.find(params[:id])
    @deelnemer.destroy
    redirect_to :action => "index"
  end

  # Code copied in: inschrijven_controller.rb
  # Code copied in: aanmelden_controller.rb
  private 

    def deelnemer_params
      params.require(:deelnemer).permit(:voornaam, :achternaam, :tussenvoegsel, :geboortedatum, :email, :telefoonnummer, :knsbnummer, :rating)
    end

    def deelnemer_update_params
      params.require(:deelnemer).permit(:email, :telefoonnummer, :knsbnummer, :rating)
    end

    def deelnemer_ess_params
      params.require(:deelnemer).permit(:voornaam, :tussenvoegsel, :achternaam, :geboortedatum)
    end

end
