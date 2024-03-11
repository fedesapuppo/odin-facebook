Rails.application.routes.draw do
  resources :friend_requests, only %i(create)
  resources :friends, only: %i(index)
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
