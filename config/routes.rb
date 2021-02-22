Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  root to: "posts#index"
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
  get '/users/:id', to: 'users#show', as: 'user'
end
