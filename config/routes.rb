Rails.application.routes.draw do
  get 'sessions/new'
  root to: 'tasks#index'
  #root to: 'users#index'


  resources :tasks
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
