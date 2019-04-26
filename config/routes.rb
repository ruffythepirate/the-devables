Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get 'blog_posts/new'
  match 'signup', to: 'users#new', via: 'get'
  match 'signup', to: 'users#create', via: 'post'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :thoughts
  resources :users
  resources :blog_posts
  resources :account_activations, only: [:edit]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/api/blog-post/md-to-html', to: 'blog_posts#md_to_html'
  post '/api/blog-posts', to: 'blog_posts#create'

  root 'thoughts#index'

end
