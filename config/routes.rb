Rails.application.routes.draw do
  get "notifications/index"
  root "pages#home"
  devise_for :users
  resources :posts
  resources :notifications, only: [:index]
  put "accept_friend_request/:id", to: "friend_requests#accept", as: "accept_friend_request"
  put "reject_friend_request/:id", to: "friend_requests#reject", as: "reject_friend_request"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
