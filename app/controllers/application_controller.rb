class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def deelnemers
    redirect_to deelnemers_path
  end

  def toernoois
    redirect_to toernoois_path
  end

  def homepage
    render html: "See /toernoois and /deelnemers"
  end
end
