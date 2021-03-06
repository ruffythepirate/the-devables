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

  get '/blog', to: 'public_blog_posts#index'
  get '/blog/:id', to: 'public_blog_posts#show'

  post '/api/blog-post/md-to-html', to: 'blog_posts#md_to_html'
  post '/api/blog-posts', to: 'blog_posts#create'
  post '/api/blog-posts/:id/set-published', to: 'blog_posts#set_published'

  get '/api/user/post-list', to: 'blog_posts#get_user_post_list'

  root 'public_blog_posts#index'
end
