class DeelnemersController < ApplicationController

  def index
    @deelnemers = Deelnemer.all
  end

  def show
    @deelnemer = Deelnemer.find(params[:id])
  end

  def new
    @deelnemer = Deelnemer.new
    @controller = "deelnemers"
  end

  def create
    deelnemer_params[:tussenvoegsel] ||= ""
    @deelnemer = Deelnemer.new(deelnemer_params)
    @deelnemer.email = params[:deelnemer][:email]
    @deelnemer.telefoonnummer = params[:deelnemer][:telefoonnummer] || ""
    @deelnemer.knsbnummer = params[:deelnemer][:knsbnummer].to_i || 0
    @deelnemer.rating = params[:deelnemer][:rating].to_i || 0
    if Deelnemer.find_by(deelnemer_params) || @deelnemer.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def edit
    @deelnemer = Deelnemer.find(params[:id])
  end

  def update
    deelnemer_params[:tussenvoegsel] ||= ""
    @deelnemer = Deelnemer.find(params[:id])
    @deelnemer.update_attributes(deelnemer_params)
    @deelnemer.update_attributes(email: params[:deelnemer][:email], telefoonnummer: params[:deelnemer][:telefoonnummer], knsbnummer:params[:deelnemer][:knsbnummer], rating: params[:deelnemer][:rating])
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

  private 

    def deelnemer_params
      params.require(:deelnemer).permit(:voornaam, :achternaam, :tussenvoegsel, :geboortedatum)
    end

end
