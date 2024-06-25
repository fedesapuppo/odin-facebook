Rails.application.routes.draw do
  resources :friend_requests, only: [:create]
  resources :friends, only: [:index]
  root 'pages#home'
  devise_for :users
  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end
  resources :notifications, only: [:index]
  resources :friendship_acknowledgements, only: %i[create destroy]
  resources :friends, only: %i[index destroy]
  resources :friendships, only: %i[create destroy]
  resources :friend_requests, only: %i[create destroy]
  resources :profiles, except: %i[index destroy]
end
