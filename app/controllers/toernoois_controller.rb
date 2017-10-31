class ToernooisController < ApplicationController
  
  def index
    @toernoois = Toernooi.all
  end

  def show
    @toernooi = Toernooi.find(params[:id])
  end


  def new
    @toernooi = Toernooi.new
  end
  def create
    @toernooi = Toernooi.new(toernooi_params)
    if @toernooi.save
      @dzg = Groep.create(nummer: 0, toernooi_id: @toernooi.id)
      redirect_to @toernooi
    else
      render :action => "new"
    end
  end

  def destroy
    @toernooi = Toernooi.find(params[:id])
    @toernooi.destroy
    redirect_to toernoois_path
  end

  def partijs
    @toernooi = Toernooi.find(params[:id])
    @groeps = @toernooi.groeps.order("nummer").all
  end

  private

    def toernooi_params
      params.require(:toernooi).permit(:naam, :wedstrijdleider, :datum)
    end
    def deelnemer_params
      params.require(:deelnemer).permit(:voornaam, :achternaam, :tussenvoegsel, :geboortedatum)
    end

end
