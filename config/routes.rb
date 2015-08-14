Rails.application.routes.draw do
  apipie
  
  root "dashboard#index"

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      get "/players/:id" => "players#show"
    end
  end  
end
