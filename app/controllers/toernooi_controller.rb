class ToernooiController < ApplicationController
  def new
    @toernooi = Toernooi.new
  end
  def create
    @toernooi = Toernooi.new(toernooi_params)
    if @toernooi.save
      redirect_to :action => "new" #Waarheen?!
    else
      render :action => "new"
    end
  end

  private

    def toernooi_params
      params.require(:toernooi).permit(:naam, :wedstrijdleider, :datum)
    end
end
