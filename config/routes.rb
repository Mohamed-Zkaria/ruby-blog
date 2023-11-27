require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "/users", to: "users#create", as: :create_users
  post "/auth/login", to: "authentication#login", as: :login_users

  mount Sidekiq::Web => "/sidekiq"
  # Defines the root path route ("/")
  # root "posts#index"
end
