Rails.application.routes.draw do
  root "pages#home"
  devise_for :users
  resources :posts
  resources :notifications, only: [:index]
  resources :friendship_acknowledgements, only: [:create, :destroy]
end
