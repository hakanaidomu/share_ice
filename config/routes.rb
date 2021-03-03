Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root to: "posts#index"
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  get '/users/:id', to: 'users#show', as: 'user'
  post   '/like/:post_id' => 'likes#like',   as: 'like'
  delete '/like/:post_id' => 'likes#unlike', as: 'unlike'
  get 'tags/:tag', to: 'posts#index', as: :tag

  tagspace :api, { format: 'json' } do
    tagspace :v1 do
      resources :posts
    end
  end
end
