Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts
  get "/profiles/;id", to: "profiles#show"
end
