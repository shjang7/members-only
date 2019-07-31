# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  root    'posts#index'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  get     '/signup',  to: 'users#new'
  post    '/signup',  to: 'users#create'
  resources :posts, only: %i[new create index]
  resources :users, only: %i[new create]
end
