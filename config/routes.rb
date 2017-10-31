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
  post "/inschrijven/:id" => "inschrijven#create"
  get "/inschrijven" => "inschrijven#destroy"

  #indelen
  get "/indelen/:toernooiid" => "indelen#index"
  get "/indelen/:toernooiid/groep/:groepnummer" => "indelen#show"
  get "/indelen/:toernooiid/score" => "indelen#score"
  get "/indelen/:toernooiid/uitslag" => "indelen#uitslag"
  post "/indelen/:toernooiid" => "indelen#addingroep"
  post "/invoeren" => "indelen#invoeren"
  get "/indelen/:toernooiid/print" => "indelen#print"
  get "indelen/:toernooiid/tussenstand" => "indelen#tussenstand"

  root 'application#toernoois'
  get "/toernoois/:id/partijs" => "toernoois#partijs"

end
