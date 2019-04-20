Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  match 'signup', to: 'users#new', via: 'get'
  match 'signup', to: 'users#create', via: 'post'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :thoughts
  resources :users
  resources :account_activations, only: [:edit]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'thoughts#index'

end
