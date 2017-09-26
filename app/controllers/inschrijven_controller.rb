class InschrijvenController < ApplicationController
  def new
    @toernooi = Toernooi.find(params[:id])
    @deelnemer = Deelnemer.new
    @url = url_for(controller: "inschrijven", action: "create")
  end

  def create
    
    # Find deelnemer in Database, if it exists. Otherwise, create deelnemer
    # and register inside the database
    # Code copied (and slightly altered) from deelnemers_controller.rb, 
    # under the method create.
    @deelnemer = Deelnemer.find_by(deelnemer_ess_params) || Deelnemer.new(deelnemer_params)
    @deelnemer.tussenvoegsel ||= ""
    @deelnemer.telefoonnummer ||= ""
    @deelnemer.knsbnummer ||= 0
    @deelnemer.rating ||= 0
    @deelnemer.email = params[:deelnemer][:email]
    @deelnemer.telefoonnummer = params[:deelnemer][:telefoonnummer]
    @deelnemer.knsbnummer = params[:deelnemer][:knsbnummer]
    @deelnemer.rating = params[:deelnemer][:rating]  
    render 'new' and return "" unless @deelnemer.save #Slight change from original code

    # Find the current Toernooi
    @toernooi = Toernooi.find(params[:toernooi_id])

    # And put the deelnemer into the dummy groep 
    @dzg = @toernooi.groeps.find_by(nummer: 0)
    ( @dzg.deelnemers.push(@deelnemer) && @toernooi.deelnemers.push(@deelnemer) ) unless @toernooi.deelnemers.exists?(@deelnemer.id) 
    redirect_to @toernooi
  end

  def destroy
    # @toernooi = Toernooi.find(params[:toernooi_id])
    @deelnemer = Deelnemer.find(params[:deelnemer_id])
    @deelnemer.toernoois.delete(params[:toernooi_id])
    @deelnemer.groeps.delete(Groep.find_by(toernooi_id: params[:toernooi_id]))
    # @toernooi.deelnemers.delete(params[:deelnemer_id])

    redirect_to toernooi_path(params[:toernooi_id])
  end

  # Code copied from deelnemers_controller.rb
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
