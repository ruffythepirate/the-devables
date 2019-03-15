Rails.application.routes.draw do
  get 'users/new'
  match 'signup', to: 'users#new', via: 'get'
  match 'signup', to: 'users#create', via: 'post'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :thoughts
  resources :users

  root 'thoughts#index'
end
