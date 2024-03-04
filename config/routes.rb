Rails.application.routes.draw do
  get 'friend_requests/create'
  get 'friends/index'
  root 'pages#home'
  devise_for :users
  resources :posts do
    resources :likes, only: %i[create destroy]
  end
  resources :notifications, only: [:index]
  resources :friendship_acknowledgements, only: %i[create destroy]
  resources :friends, only: %i[index destroy]
  resources :friendships, only: %i[create destroy]
  resources :friend_requests, only: %i[create destroy]
end
