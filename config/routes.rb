Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :toernoois
  resources :deelnemers

  get "/inschrijven/:id" => "inschrijven#new"
  post "/inschrijven" => "inschrijven#create"
  get "/inschrijven" => "inschrijven#destroy"

  root 'application#homepage'
end
