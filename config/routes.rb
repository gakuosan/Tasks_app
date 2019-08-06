Rails.application.routes.draw do

  get 'login' , to: 'sessions#new'
  post 'login' , to: 'sessions#create'
  delete 'login' , to: 'sessions#destroy'




  resources :tasks
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
