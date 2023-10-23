Rails.application.routes.draw do
  get 'friend_requests/create'
  get 'friends/index'
  root "pages#home"
  devise_for :users
  resources :posts
  resources :notifications, only: [:index]
  resources :friendship_acknowledgements, only: [:create, :destroy]
  resources :friends, only: [:index, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :friend_requests, only: [:create, :destroy]
end
