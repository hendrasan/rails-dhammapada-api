Rails.application.routes.draw do
  root "application#health_check"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :chapters, only: [ :index, :show ]

      get "verses/random" => "verses#random"
      resources :verses, only: [ :index, :show ]

      get "search" => "search#index"
    end
  end
end
