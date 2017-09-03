Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :toernoois
  resources :deelnemers

  #aanmelden
  get "/aanmelden" => "aanmelden#index"
  get "/aanmelden/:id" => "aanmelden#new"
  post "/aanmelden" => "aanmelden#create"
  get "/thx" => "aanmelden#thx"

  #inschrijven
  get "/inschrijven/:id" => "inschrijven#new"
  post "/inschrijven" => "inschrijven#create"
  get "/inschrijven" => "inschrijven#destroy"

  #indelen
  get "/indelen/:toernooiid" => "indelen#index"
  get "/indelen/:toernooiid/:groepnummer" => "indelen#show"
  post "/indelen/:toernooiid" => "indelen#addingroep"

  root 'application#toernoois'

end
