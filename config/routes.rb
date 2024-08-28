Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root to: "rooms#index"
  # add devise routes here
  resources :rooms, param: :code, only: [:index, :new, :show, :create] do
    member do
      resources :players, only: [:create, :destroy]
      resources :votes, only: [:create]
      post "reveal"
      post "reset_votes"
      get "join"
    end
  end
end
