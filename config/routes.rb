require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "/users", to: "users#create", as: :create_users
  post "/auth/login", to: "authentication#login", as: :login_users

  mount Sidekiq::Web => "/sidekiq"
  
  get "/posts", to: "posts#index", as: :get_posts
  post "/posts", to: "posts#create", as: :create_posts
  put "/posts/:id/edit", to: "posts#update", as: :edit_post
  delete "/posts/:id", to:"posts#destroy", as: :delete_post

  post "/comments/:post_id/post", to: "comments#create", as: :create_comment
  put "/comments/:comment_id", to: "comments#update", as: :update_comment
  delete "/comments/:comment_id", to: "comments#destroy", as: :delete_comment

  # Defines the root path route ("/")
  # root "posts#index"
end
