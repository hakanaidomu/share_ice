Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts
  get '/users/:id', to: 'users#show', as: 'user'
end
