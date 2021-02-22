Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts do
    resources :comments
  end
  get '/users/:id', to: 'users#show', as: 'user'
end
