Rails.application.routes.draw do
  devise_for :users
  root to: "share_ices#index"
  resources :items
end
